function C = fisheye_longitude_correction_other(A, T)
tic;
[A,R]=imageEffectiveAreaInterception(A,T);
[m,n,k]=size(A);
C=[];
x=n/2;
y=m/2;
for u=1:m
    for v=1:n
        i=u;
        j=round(sqrt(R^2-(y-u)^2)*(v-x)/R+x);
        if(R^2-(y-u)^2<0)
            continue;
        end
        C(u,v,1)=A(i,j,1);
        C(u,v,2)=A(i,j,2);
        C(u,v,3)=A(i,j,3);
    end
end
C=uint8(C);
toc;
end
