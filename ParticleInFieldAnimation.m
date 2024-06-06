clc
clear all
close all
format long

a=input('Magnetic Field magnitude:');
b=input('Electric Field magnitude:');
c=input('Charge of the particle:');
B=a*[0;0;1];
E=b*[1;1;0];

if c==-1
    q=-1.6e-19;
    m=9.1e-31;
elseif c==+1
    q=1.6e-19;
    m=1.7e-27;
else
    q=0;
    m=1.7e-27;
end

r0=[0;0;0];
V0=100000*[1;1;0.3];
tm=1e-8;
dt=tm/10000;
ts=0:dt:tm;
R=zeros(6,length(ts));
Rc=1;

for t=ts
    if Rc~=1
        V=R(4:6,Rc-1);
        F=q*(E+cross(V,B));
        R(:,Rc)=R(:,Rc-1)+([V;F/m])*dt;
    else
        R(:,Rc)=[r0;V0];
    end
    Rc=Rc+1;
end

figure('units','normalized','outerposition',[0 0 1 1]);
hpar=axes;
hold on;
grid on
axis equal;
light;
xlabel('X');
ylabel('Y');
zlabel('Z');
sc=1e-4;
xlim([-3*sc 3*sc]);
ylim([-5*sc 5*sc]);
zlim([-4*sc 4*sc]);
En=sqrt(E(1)^2+E(2)^2+E(3)^2);
Bn=sqrt(B(1)^2+B(2)^2+B(3)^2);

arrow(r0(1),r0(2),r0(3),(E(1)/En)*sc,(0/En)*sc,(E(3)/En)*sc,0.2*sc,0.01*sc,[1 0 0],hpar);
text(r0(1)+(E(1)/En)*sc*1.2,r0(2)+(0/En)*sc*1.2,r0(3)+(E(3)/En)*sc*1.2,'E');
arrow(r0(1),r0(2),r0(3),(0/En)*sc,(E(2)/En)*-1*sc,(E(3)/En)*sc,0.2*sc,0.01*sc,[1 0 0],hpar);
text(r0(1)+(0/En)*sc*1.2,r0(2)+(E(2)/En)*sc*1.2,r0(3)+(E(3)/En)*sc*1.2,'E');
arrow(r0(1),r0(2),r0(3),(B(1)/Bn)*sc,(B(2)/Bn)*sc,(B(3)/Bn)*sc,0.2*sc,0.01*sc,[0 0 1],hpar);
text(r0(1)+(B(1)/Bn)*sc*1.2,r0(2)+(B(2)/Bn)*sc*1.2,r0(3)+(B(3)/Bn)*sc*1.2,'B');

ac=10;
ts1=0:dt*ac:tm/2;
pth=plot3(R(1,1),R(2,1),R(3,1),'r-');
hs=sphereic(0,0,0,1e-5,[1 1 1],1,hpar);
Xs=get(hs,'XData');
Ys=get(hs,'YData');
Zs=get(hs,'ZData');
lc=1;
lc0=1;
d=0;
e=-2*pi;

for t=ts1
    set(pth,'XData',R(1,1:lc),'YData',R(2,1:lc),'ZData',R(3,1:lc));
    set(hs,'XData',Xs+R(1,lc),'YData',Ys+R(2,lc),'ZData',Zs+R(3,lc));
    drawnow;
    lc=lc+ac;
    lc0=lc0+1;
    view(-90+d,45*sin(e));
    d=d+180/500;
    e=e+pi/500;
end   