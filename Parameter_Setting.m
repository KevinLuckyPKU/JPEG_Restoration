function par = Parameter_Setting( par )
                
par.maxIter     =     100; 
par.step        =     2;
par.patchsize   =     6; 
par.psf         =     fspecial('gauss', par.patchsize, 1.5);
par.SearchWin   =     30;
par.nblk        =     30;
par.hp          =     65;
par.omega       =     0.25;   % 0.3 in the paper (0.25 can get better results)
par.delta   =     3; 
if(par.qp >= 5 && par.qp<15)
    par.c1      =     25;
elseif(par.qp >= 15 && par.qp<=25)
    par.c1      =     20;
else
    par.c1      =     15;
end
end


