function [ Usum ] = compute_potentials (X,Xsum,k,m,n,Po,a)
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here
Rat=(X(1)-Xsum(1,1))^2+(X(2)-Xsum(1,2))^2;%·�����Ŀ��ľ���ƽ��
rat=sqrt(Rat);%·�����Ŀ��ľ���
for i=1:n
Rrei(i)=(X(1)-Xsum(i+1,1))^2+(X(2)-Xsum(i+1,2))^2;%·������ϰ��ľ���ƽ��
rre(i)=sqrt(Rrei(i));%·������ϰ��ľ��뱣��������rrei��
R0=(Xsum(1,1)-Xsum(i+1,1))^2+(Xsum(1,2)-Xsum(i+1,2))^2;
r0=sqrt(R0);
if rre(i)>Po%���ÿ���ϰ���·���ľ�������ϰ�Ӱ����룬������Ϊ0
Urer(i)=0;
else
Urer(i)=0.5*m*(1/rre(i)-1/Po)^2*(rat^a);
end
end
Uatt=0.5*k*Rat;
Usum=sum(Urer)+Uatt;

