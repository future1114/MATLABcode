clc;clear
a=20;
x=-2:0.01:2;

figure(1);
set(gcf,'position',[0,0,800,600],'color','w');
for i=1:200
    str_title=strcat('\color{red}a=',num2str(a));
    y=abs(x).^(2/3)+(0.9*sqrt((3.3-x.^2))).*sin(a*pi*x);
    a=i/10;
    figure(i);
    set(gcf,'position',[0,0,800,600],'color','w');
    pl=plot(x,y,'r','LineWidth',3);
    hold on
    %title('\color{red}f(x)=x^2^/^3+e/3*(pi-x^2)^1')
    text(-0.2,2.3,str_title,'FontName','TIme New Roman','FontSize',20);
    xlim([-2 2]);
    ylim([-1.5 2.5]);
    frame=getframe(gcf);
    im=frame2im(frame);
    [I,map]=rgb2ind(im,256);
    if i==1
        imwrite(I,map,'ÐÄ.gif','gif','Loopcount',Inf,'DelayTime',0.05);
    else
        imwrite(I,map,'ÐÄ.gif','gif','WriteMode','append','DelayTime',0.05);
    end
    close(figure(i))
end
