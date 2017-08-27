function [ x11 ,y11 ,x22, y22 ,x33, y33 ] = location_of_tdoa( a1, a2, a3,b1 , b2 ,b3,theta1,theta2,theta3,X10,Y10,X20,Y20,X21,Y21 )
% distance of tdoa 
%   采用遍历手法来计算交点坐标
da = 1e-3;
db = 1e-3;

for sigma0 = 0 :da:pi*2
    x11 = (a1./cos(sigma0))*cos(theta1) - (b1*tan(sigma0))*sin(theta1)+X10;
    y11 = (a1./cos(sigma0))*sin(theta1) + (b1*tan(sigma0))*cos(theta1)+Y10;
    for sigma1 =0 : db : pi*2
        x22 = (a2./cos(sigma1))*cos(theta2) - (b2*tan(sigma1))*sin(theta2)+X20;
        y22 = (a2./cos(sigma1))*sin(theta2) + (b2*tan(sigma1))*cos(theta2)+Y20;
        dis1 =  sqrt((x11-x22)^2 + (y11-y22)^2);
        if dis1<2
            for sigma2 = 0 : db : 2*pi
                x33 = (a3./cos(sigma2))*cos(theta3) - (b3*tan(sigma2))*sin(theta3)+X21;
                y33 = (a3./cos(sigma2))*sin(theta3) + (b3*tan(sigma2))*cos(theta3)+Y21;
                dis2 =  sqrt((x11-x33)^2 + (y11-y33)^2);
                dis3 =  sqrt((x22-x33)^2 + (y22-y33)^2);
                if dis2<2 && dis3<2
                    for sigma01 = sigma0-da:da/10:sigma0+da;%改变步长进一步提高定位精度************************
                        x11 = (a1./cos(sigma01))*cos(theta1) - (b1*tan(sigma01))*sin(theta1)+X10;
                        y11 = (a1./cos(sigma01))*sin(theta1) + (b1*tan(sigma01))*cos(theta1)+Y10;
                        for sigma11 =sigma1-da : da/10 : sigma1+da
                            x22 = (a2./cos(sigma11))*cos(theta2) - (b2*tan(sigma11))*sin(theta2)+X20;
                            y22 = (a2./cos(sigma11))*sin(theta2) + (b2*tan(sigma11))*cos(theta2)+Y20;
                            dis1 =  sqrt((x11-x22)^2 + (y11-y22)^2);
                            if dis1<0.2 
                                for sigma21 = sigma2 - da : da/10 : 2*pi
                                    x33 = (a3./cos(sigma21))*cos(theta3) - (b3*tan(sigma21))*sin(theta3)+X21;
                                    y33 = (a3./cos(sigma21))*sin(theta3) + (b3*tan(sigma21))*cos(theta3)+Y21;
                                    dis2 =  sqrt((x11-x33)^2 + (y11-y33)^2);
                                    dis3 =  sqrt((x22-x33)^2 + (y22-y33)^2);
                                    if dis2<0.2 && dis3<0.2%最终定位精度为三边不超过0.2的三角形区域*************
                                        plot(x11,y11,'or');
                                        hold on;
                                        plot(x22,y22,'ob');
                                        hold on;
                                        plot(x33,y33,'og');
                                        hold on;
                                        plot((x11+x22+x33)/3,(y11+y22+y33)/3,'*r');
                                    end
                                end
                            end
                        end
                    end
                end
            end
        end
    end
end
end

