function [ x,y ] = TDOA( )
% 利用TDOA实现无线定位

%参数设定
C = 3e8;
x = 0;
y = 0;
n = input('请输入锚节点个数：');
number_of_location = nchoosek(n,3);
for i=1 : n
    N(i)=i;
end

M = combntns(N,3);

for i=1 : n
    t(i) = input(sprintf('请输入到达节点%d的时间：',i));
end
for i=1 : n
    A = anchor_node_coordinate(i);
    X(i) = A(1);
    Y(i) = A(2);
    plot(X(i),Y(i),'*r');
    hold on;
end
%求取双曲线在水平方向的仿射图像
%*************************************************************************************************************
tic;
for i=1 : number_of_location
    X1 = X(M(i,1));Y1 = Y(M(i,1));
    X2 = X(M(i,2));Y2 = Y(M(i,2));
    X3 = X(M(i,3));Y3 = Y(M(i,3));
    delta_D1 = abs((t(M(i,1))-t(M(i,2))))*C;
    delta_D2 = abs((t(M(i,1))-t(M(i,3))))*C;
    delta_D3 = abs((t(M(i,2))-t(M(i,3))))*C;
    a1 = (delta_D1)/2;
    a2 = (delta_D2)/2;
    a3 = (delta_D3)/2;

    focus0 = sqrt((X1-X2)^2+(Y1-Y2)^2)/2;
    focus1 = sqrt((X1-X3)^2+(Y1-Y3)^2)/2;
    focus2 = sqrt((X3-X2)^2+(Y3-Y2)^2)/2;
    b1 = sqrt(focus0^2-a1^2);
    b2 = sqrt(focus1^2-a2^2);
    b3 = sqrt(focus2^2-a3^2);

    sigma = 0:1e-3:2*pi;
    x1 = a1./cos(sigma);
    y1 = b1*tan(sigma);
    x2 = a2./cos(sigma);
    y2 = b2*tan(sigma);
    x3 = a3./cos(sigma);
    y3 = b3*tan(sigma);

%仿射变换求取实际双曲线
%*************************************************************************************************************
    X21 = (X2+X1)/2;Y21 = (Y2+Y1)/2;
    X31 = (X3+X1)/2;Y31 = (Y3+Y1)/2;
    X32 = (X2+X3)/2;Y32 = (Y3+Y2)/2;
    if X2-X1 == 0
        theta1 = pi/2;
    else
        k1 = (Y2-Y1)/(X2-X1);
        theta1 = atan(k1);
    end
    if X3-X1 == 0
        theta2 = pi/2;
    else
        k2 =(Y3-Y1)/(X3-X1);
        theta2 = atan(k2);
    end
    if X2-X3 == 0
        theta3 = pi/2;
    else
        k3 =(Y2-Y3)/(X2-X3);
        theta3 = atan(k3);
    end

    x21 = x1*cos(theta1)-y1*sin(theta1)+X21;%(x10,y10)为锚节点01之间拟合的双曲线
    y21 = x1*sin(theta1)+y1*cos(theta1)+Y21;
    x31 = x2*cos(theta2)-y2*sin(theta2)+X31;%(x20,y20)为锚节点02之间拟合的双曲线
    y31 = x2*sin(theta2)+y2*cos(theta2)+Y31;
    x32 = x3*cos(theta3)-y3*sin(theta3)+X32;%(x21,y21)为锚节点21之间拟合的双曲线
    y32 = x3*sin(theta3)+y3*cos(theta3)+Y32;

%     plot(x21,y21,'r');
%     hold on;
%     plot(x32,y32,'g');
%     hold on;
%     plot(x31,y31,'b');
%     hold on;
%     plot(X21,Y21,'ok');
%     hold on;
%     plot(X31,Y31,'ok');
%     hold on;
%     plot(X32,Y32,'ok');
%*************************************************************************************************************
%                                         求取定位坐标                                                       
%*************************************************************************************************************
    location_of_tdoa( a1, a2, a3,b1 , b2 ,b3,theta1,theta2,theta3,X21,Y21,X31,Y31,X32,Y32 );
end
axis auto;
grid on;
end

