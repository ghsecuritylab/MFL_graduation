function [ X_next,Fsum_next,step_r] = jump_minimum(Fsum_d,X,Xsum,k,m,n,Po,a,l);
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here
Fsum_old=Fsum_d;
X_next(1,1)=X(1,1);
X_next(1,2)=X(1,2);
Fsum_next(1)=Fsum_d;
step_r=1;
for i=1:50
    [ Fsum,X_next_t,Fsum_next_t,step ] = solve(Fsum_old,X,Xsum,k,m,n,Po,a,l);
    if Fsum< Fsum_old
        Fsum_old=Fsum;
        for j=1:step
           X_next(j,1) =X_next_t(j,1);
           X_next(j,2) =X_next_t(j,2);
           Fsum_next(j)=Fsum_next_t(j);
        end
    step_r=step;
    end
end
end
function [ Fsum,X_new,Fsum_next_t,step ] = solve(Fsum_o,X,Xsum,k,m,n,Po,a,l)
max_temper = 1000;
dec = 0.80;
temp = max_temper;
X_new(1,1)=X(1);
X_new(1,2)=X(2);
Fsum_next_t(1)=Fsum_o;
Fsum_old=Fsum_o;
step=1;
while(temp>10)
     angle=rand()*pi;
     X_next_try(1)=X_new(step,1)+l*cos(angle);
     X_next_try(2)=X_new(step,2)+l*sin(angle);
%     Theta=compute_angle(X_next_try,Xsum,n);
%     Angle=Theta(1);%Theta��1���ǳ���Ŀ��֮��ĽǶȣ�Ŀ��Գ���������
%     angle_at=Theta(1);%Ϊ�˺��������������������ķ�����ֵ��angle_at
%     [Fatx,Faty]=compute_Attract(X_next_try,Xsum,k,Angle,0,Po,n);
%     for i=1:n
 %       angle_re(i)=Theta(i+1);%��������õĽǶȣ��Ǹ���������Ϊ��n���ϰ�������n���Ƕȡ�
%     end
    %���ü������ģ��
%     [Frerxx,Freryy,Fataxx,Fatayy]=compute_repulsion(X_next_try,Xsum,m,angle_at,angle_re,n,Po,a);%�����������x,y����ķ������顣
%     Fsumyj=Faty+Freryy+Fatayy;%y����ĺ���
%     Fsumxj=Fatx+Frerxx+Fataxx;%x����ĺ���
%     Fsum=sqrt(Fsumyj^2+Fsumxj^2);
    [Usum]=compute_potentials(X_next_try,Xsum,k,m,n,Po,a);
    Fsum=Usum;
     if((Fsum-Fsum_old<500)&&((Fsum-Fsum_old<=0)||(rand()<=exp((Fsum_old-Fsum)/temp))||(X_next_try(1)-Xsum(1,1)+X_next_try(2)-Xsum(1,2)<0.2)))
         step=step+1;
         X_new(step,1)=X_next_try(1);
         X_new(step,2)=X_next_try(2);
         Fsum_next_t(step)=Fsum;
         
     end
     temp=temp*dec;
end
         
    
end


