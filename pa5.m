global C
C.q_0 = 1.60217653e-19;             % electron charge
C.hb = 1.054571596e-34;             % Dirac constant
C.h = C.hb * 2 * pi;                    % Planck constant
C.m_0 = 9.10938215e-31;             % electron mass
C.kb = 1.3806504e-23;               % Boltzmann constant
C.eps_0 = 8.854187817e-12;          % vacuum permittivity
C.mu_0 = 1.2566370614e-6;           % vacuum permeability
C.c = 299792458;                    % speed of light
C.g = 9.80665; %metres (32.1740 ft) per s²
C.am = 1.66053892e-27;

nx=50;
ny=50;
G = sparse(nx*ny);
B = zeros(1,nx*ny);

for i= 1:nx
    for j= 1:ny
        
        n= j+(i-1)*ny;
        nxm = j + (i-2)*ny;
        nxp= j+(i)*ny;
        nym= (j-1)+(i-1)*ny;
        nyp= (j+1)+(i-1)*ny;
        
        
        if i==1 %left
            G(n,:)=0;
            G(n,n)=1;
            
        elseif i==nx%right
            G(n,:)=0;
            G(n,n)=1;
            
        elseif j==1 %bottom
            G(n,:)=0;
            G(n,n)=1;
        elseif j ==ny
            G(n,:)=0;
            G(n,n)=1;
        else %bulk
            
            if i > 10 && i < 20 && j > 10 && j < 20
                 G(n,n)=      -2;
            else
                G(n,n)=      -4;
            end
            G(n,nxm)=    1;
            G(n,nxp)=    1;
            G(n,nyp)=    1;
            G(n,nym) = 1;
            
        end
    end
end
figure(1)
spy(G);
[E,D] = eigs(G,9,'SM');


for k = 1:9
    Vmap=zeros(nx,ny);
    for i=1:nx
        for j=1:ny
            n=j+(i-1)*ny;
            Vmap(i,j)=E(n,k);
        end
    end
    % z=diag(D);
    % figure(2)
    % plot(z);
    % surf(D);
    figure(k)
    surf(Vmap)
end





