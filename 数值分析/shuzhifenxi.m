% clear;close;clc
% a=input('���������������˵� a=');
% b=input('��������������Ҷ˵� b=');
% % a1=input('�����뻮��������');
% % b1=input('�����뻮��������');
% format long
% ArrT=zeros(10,1);
% ArrS=zeros(10,1);
% ArrN=zeros(10,1);
% for n=1:10
%     syms t
%     Ft=t/(4+t^2);
%     %Ft=1/(1+2*t^2);
%     h=(b-a)/n;
%     fa=subs(Ft,a);
%     fb=subs(Ft,b);
%     Xt=a+h:h:b-h;
%     ft=sum(subs(Ft,Xt));
%     %���ι�ʽ
%     Tn=(h/2)*(fa+2*ft+fb);
%     ArrT(n,1)=double(Tn);
%     %Simpson ��ʽ
%     Xs=a+h/2:h:b-h/2;
%     Sn=(h/6)*(fa+4*sum(subs(Ft,Xs))+2*ft+fb);
%     ArrS(n,1)=double(Sn);
%     %Newton-Cotes��ʽ
%     
% end
% ArrT1=zeros(9,1);
% ArrS1=zeros(9,1);
% for n1=1:n-1
%     ArrT1(n1,1)=abs(ArrT(n1+1,1)-ArrT(n,1));
%     ArrS1(n1,1)=abs(ArrS(n1+1,1)-ArrS(n,1));
% end
% n2=1:8;
% hold on
% plot(n2,ArrT1(8,1))
% plot(n2,ArrS1(8,1))
% legend('���ι�ʽ','Simpson ��ʽ')
% hold off

%%
clear;close;clc
a=input('���������������˵� a=');
b=input('��������������Ҷ˵� b=');
n=2;
syms t;
syms Ck1;
Ft=t/(4+t^2);
%Ft=1/(1+2*t^2);
h=(b-a)/n;
I1=0;Ck=1;Ck1=1;
for k=0:n
    for j=0:n
        if j~=k
           Ck1=Ck1*(t-j);
        end
    end
    Ck2=int(Ck1,0,n);
    Ck=Ck2*(-1)^(n-k)/(n*factorial(k)*factorial(n-k));
    I1=I1+Ck*subs(Ft,a+k*h);
end
I=I1*(b-a);
I3=double(I);


%%
clear;close;clc
a=input('���������������˵� a=');
b=input('��������������Ҷ˵� b=');
n=5;
syms t;
syms Ck1;
%Ft=t/(4+t^2);
Ft=1/(1+2*t^2);
h=(b-a)/n;
I1=0;Ck=1;Ck1=1;
for k=0:n
    for j=0:n
        if j~=k
           Ck1=Ck1*((t-j)/(k-j));
        end
    end
    Ck2=int(Ck1,0,n);
    Ck=Ck2*(h/(b-a));
    I1=I1+Ck*subs(Ft,a+k*h);
end
I=I1*(b-a);
I3=double(I)
