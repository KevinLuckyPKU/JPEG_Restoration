% =========================================================================
% Compressed Image Restoration, Version 1.0
% Copyright(c) 2020 Qiang Song
% All Rights Reserved.
%------------------------------------------------------------------------
% This is an implementation of the algorithm for JPEG image restoration.
% 
% Please cite the following paper if you use this code:
%
% "Compressed Image Restoration via Artifacts-Free PCA Basis Learning and 
% Adaptive Sparse Modeling" (TIP 2020)
% 
%--------------------------------------------------------------------------
clear;clc;close all;
addpath('Data');
%%
im_path      =   'Data';
fpath       =   fullfile(im_path, '*.tif');
im_dir      =   dir(fpath);
im_num      =   length(im_dir);
psnr_M = [];
ssim_M = [];
%%
qp = 10; 
%%
for  i  =  1 : im_num
    
    imname          =   im_dir(i).name;
    orig_img        =   double( imread(fullfile(im_path , imname)) ); 
    
    [h w ch]  =  size(orig_img);

    if  ch==3
        lrim      =  rgb2ycbcr( uint8(orig_img) );
        orig_img        =  double( lrim(:,:,1));    
    end
    orig_img = modcrop(orig_img,8);
    par.qp          =   qp;  
    fprintf( 'Image = %s, Quality Factor = %d\n', imname, qp);
    par.Qtab        =   jpeg_qtable(par.qp); 
    
    filename        =   strcat('Compressed_img',num2str(i),'_qp',num2str(qp),'.jpg');
    imwrite(orig_img./255,fullfile(filename),'Quality',qp);
    jpg_img         =   double(imread(filename));
    csnr(jpg_img,orig_img,0,0) 
    cal_ssim( jpg_img,orig_img,0,0)
    
    par.orig        =   orig_img;         
    par.cimg        =   jpg_img; 
    
    %%
    par                 =   Parameter_Setting(par);
    Result_Proposed     =   Compression_Artifacts_Removal( par );
    psnr_M = [psnr_M csnr(Result_Proposed,orig_img,0,0)]
    ssim_M = [ssim_M cal_ssim( Result_Proposed, orig_img, 0, 0 )]
    filename        =   strcat('Results\Restored_img',num2str(i),'_qp',num2str(qp),'_PSNR_',num2str(csnr(Result_Proposed,orig_img,0,0)),'.png');
    imwrite(uint8(Result_Proposed),filename);
end
mean(psnr_M,2)
mean(ssim_M,2)