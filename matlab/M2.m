clear all;
%�ϰ���Ŀ�꣬��ʼλ�ö���֪��·���滮,��ͼʵ�ִ������Թ滮��һ���ܿ��ϰ�����Ŀ���·����
%��ʼ�����Ĳ��� 
Xo=[0 0];
%���λ��
k=15;%����������Ҫ������ϵ��
K=1;%��ʼ��
m=5;%�������������ϵ���������Լ��趨�ġ�
Po=2;%�ϰ�Ӱ����룬���ϰ��ͳ��ľ�������������ʱ������Ϊ0�������ܸ��ϰ���Ӱ�졣Ҳ���Լ��趨��
n=50;%�ϰ�����
a=1;%�Ľ��ĳ��������е�����Ŀ������a����
l=0.2;%����
J=200;%ѭ����������
step=0;
start=1;
%�������ʵ��Ԥ��Ŀ�꣬����Ҳ���ʼ������ϵ����Po���õĲ������йء�
%end
%�����ϰ���Ŀ����Ϣs
matx=rand(n,2)*10;
matx2=[10 10];
Xsum=[matx2;matx];
%Xsum(2,1)=9.8;
%Xsum(2,2)=9.9;
%load 'G:\graduation_project\simulation\Xsum.mat';
%load Xsum.mat;
%Xsum=[10 10;1 1.5;3 2.2;4 4.5;3 6;6 2;5.5 6;4.5 3;8 8.2;4 3.2;8 6;5.3 3.6;5.1 2.9;7.9 8.3;5.8 7;8 8;8.2 8.9;3 4.5;6.7 2];%���������(n+1)*2ά������[10 10]��Ŀ��λ�ã�ʣ�µĶ����ϰ���λ�á�
Xj=Xo;%j=1ѭ����ʼ����������ʼ���긳��Xj
%***************��ʼ����������ʼ����ѭ��******************
%for j=1:J%ѭ����ʼ
j=0;
while(j<200)
    j=j+1;
Goal(j,1)=Xj(1);%Goal�Ǳ��泵�߹���ÿ��������ꡣ�տ�ʼ�Ƚ����Ž���������
Goal(j,2)=Xj(2); %���ü���Ƕ�ģ��
Theta=compute_angle(Xj,Xsum,n);%Theta�Ǽ�������ĳ����ϰ�����Ŀ��֮�����X��֮��ļнǣ�ͳһ�涨�Ƕ�Ϊ��ʱ�뷽�������ģ����Լ��������
%���ü�������ģ��
Angle=Theta(1);%Theta��1���ǳ���Ŀ��֮��ĽǶȣ�Ŀ��Գ���������
angle_at=Theta(1);%Ϊ�˺��������������������ķ�����ֵ��angle_at
[Fatx,Faty]=compute_Attract(Xj,Xsum,k,Angle,0,Po,n);%�����Ŀ��Գ���������x,y�������������ֵ��
for i=1:n
angle_re(i)=Theta(i+1);%��������õĽǶȣ��Ǹ���������Ϊ��n���ϰ�������n���Ƕȡ�
end
%���ü������ģ��
[Frerxx,Freryy,Fataxx,Fatayy]=compute_repulsion(Xj,Xsum,m,angle_at,angle_re,n,Po,a);%�����������x,y����ķ������顣
%��������ͷ����������⣬Ӧ��������ÿ��jѭ����ʱ������Ĵ�СӦ����һ��Ψһ�������������顣Ӧ�ðѳ��������з�����ӣ��������з�����ӡ�
Fsumyj=Faty+Freryy+Fatayy;%y����ĺ���
Fsumxj=Fatx+Frerxx+Fataxx;%x����ĺ���
%Fsumyj=Faty+Freryy;%y����ĺ���
%Fsumxj=Fatx+Frerxx;%x����ĺ���
%Fsum(j)=sqrt(Fsumyj^2+Fsumxj^2);
[ Usum ]=compute_potentials (Xj,Xsum,k,m,n,Po,a);
Fsum(j)=Usum;
%Fsumyj=Faty+Freryy;%y����ĺ���
%Fsumxj=Fatx+Frerxx;%x����ĺ���

Position_angle=atan(Fsumyj/Fsumxj);%������x�᷽��ļн����� %���㳵����һ��λ��
if (((Fsumyj<0)&(Fsumxj<0))|((Fsumyj>0)&(Fsumxj<0)))
Position_angle=Position_angle+pi;
end
Xnext(1)=Xj(1)+l*cos(Position_angle);
Xnext(2)=Xj(2)+l*sin(Position_angle); %���泵��ÿһ��λ����������
Xj=Xnext; %�ж�
%if ((Xj(1)-Xsum(1,1))>0)&((Xj(2)-Xsum(1,2))>0)%��Ӧ����ȫ��ȵ�ʱ�������������ֻ�ǽӽ��Ϳ��ԣ����ڰ���ȫ��ȵ�ʱ���̡�
if (sqrt((Xj(1)-Xsum(1,1))^2+(Xj(2)-Xsum(1,2))^2)<0.15)
K=j;%��¼���������ٴΣ�����Ŀ�ꡣ
break;
%��¼��ʱ��jֵ
end%���������if�����������·���ѭ��������ִ�С�

if (j>10)
    if( abs(Goal(j,1)-Goal(j-9,1))+abs(Goal(j,2)-Goal(j-9,2))<0.4)
    [ Usum ] = compute_potentials (Xj,Xsum,k,m,n,Po,a);%%%        
        start=j;
        [X_next,Fsum_next,step]=jump_minimum(Fsum(j),Xj,Xsum,k,m,n,Po,a,l);
        for k=1:step-1
            Goal(k+j,1)=X_next(k+1,1);
            Goal(k+j,2)=X_next(k+1,2);
            Fsum(k+j)=Fsum_next(k+1);
        end
        Xj(1)=X_next(step,1);
        Xj(2)=X_next(step,2);
        j=j+step-1;
    end
end

end%��ѭ������ K=j;
Goal(K,1)=Xsum(1,1);%��·�����������һ���㸳ֵΪĿ��
Goal(K,2)=Xsum(1,2);
%***********************************�����ϰ�����㣬Ŀ�꣬·����************************* %����·��
X=Goal(:,1);
Y=Goal(:,2);
%·������Goal�Ƕ�ά����,X,Y�ֱ��������x,yԪ�صļ��ϣ�������һά���顣
%�ϰ���x���� 4 3.2;5.1 2.9;7.9 8.3;5.8 7;8 8;8.2 8.9;3 4.5;6.7 2
x=Xsum(:,1);
y=Xsum(:,2);

figure(1)
plot(x,y,'o',10,10,'v',0,0,'ms',X,Y,'.-r',X(start),Y(start),'*g',X(start+step),Y(start+step),'*g');
xlabel('X/m');
ylabel('Y/m');
title('Map (X - Y)');
text(1,6,num2str(K));%�൱��text(x,y,'2')
figure(2)
plot(Fsum,'.-b')
hold on
xlabel('t/s');
ylabel('U(t)/v');
title('Potential - Step');
plot(start,Fsum(start),'*g',start+step,Fsum(start+step),'*g');

%save 'G:\graduation_project\simulation\Xsum' Xsum;





