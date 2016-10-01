% ULAZNI PARAMETRI (dodatno obja�njenje je u prezentaciji)
% cities - koordinate gradova
% Nants - broj mravi
% a (alfa) - pozitivan parametar koji kontrolira relativnu va�nost feromona
% b (beta) - pozitivan parametar koji kontrolira relativnu va�nost heuristi�ke informacije
% rr - parametar brzine isparavanja feromona
% q0 - parametar eksploracije
% Q - proizvoljna konstanta (obi�no se postavlja na 1)
% maxit - maksimalan broj iteracija

% IZLAZNI PARAMETAR
% dbest - duljina najbolje prona�ene rute u maxit iteracija
% Algoritam dodatno ispisuje broj iteracije, najbolje rje�enje u toj iteraciji i najbolje globalno rje�enje 
% crta svoj napradak po iteracijama, te crta gradove povezane najboljom
% prona�enom rutom.

function [dbest,best_it]=TSP_ACS_ACO(cities,Nants,a,b,rr,q0,Q,maxit)


xcity=cities(:,1)'; ycity=cities(:,2)'; % koordinate gradova
Ncity=length(xcity);
dcity=zeros(Ncity,Ncity);
for ic=1:Ncity-1
    for id=(ic+1):Ncity
        dcity(ic,id)=sqrt((xcity(ic)-xcity(id))^2+(ycity(ic)- ycity(id))^2);
    end % id
end %ic

for ic=2:Ncity
    for id=1:ic-1
        dcity(ic,id)=dcity(id,ic);
    end
end

vis=1./dcity; % heuristi�ka informacija (inverz udaljenosti)
nn_len=nn_tsp(cities);
phmone=1/(nn_len * Ncity)*ones(Ncity,Ncity);% incicijalizacija feromona izme�u gradova

dbest=9999999;
tour=zeros(Nants,Ncity);
dist=zeros(Nants,1);
dd=zeros(maxit,2);
% inicijaliziramo ture
for ic=1:Nants
    tour(ic,:)=randperm(Ncity);
end % ic
tour(:,Ncity+1)=tour(:,1); % tura zavr�ava u gradu u kojem po�inje
for it=1:maxit
    % tra�imo turu po gradovima za svakog mrava
    % st je trenutni grad
    % nxt sadr�i ostale gradove koje jo� treba posjetiti
    for ia=1:Nants
        
        
          for iq=2:Ncity-1
                q=rand();
              if(q<=q0)
              
          st=tour(ia,iq-1); nxt=tour(ia,iq:Ncity);
          
           value=(phmone(st,nxt)) .*(vis(st,nxt).^b);
           [~,ind_nxt]=max(value);
           newcity=iq-1+ind_nxt; % sljede�i grad koji trebamo posjetiti
           temp=tour(ia,newcity); % stavljamo novi grad u nizu
           tour(ia,newcity)=tour(ia,iq);
           tour(ia,iq)=temp;   
            
            
              else
        
            
            st=tour(ia,iq-1); nxt=tour(ia,iq:Ncity);
            prob=((phmone(st,nxt).^a).*(vis(st,nxt).^b))./sum((phmone(st,nxt).^a).*(vis(st,nxt).^b));
            rcity=rand;
            for iz=1:length(prob)
                if (rcity<sum(prob(1:iz)))
                    newcity=iq-1+iz; % sljede�i grad koji trebamo posjetiti
                    break
                end % if
            end % iz
            temp=tour(ia,newcity); % stavljamo novi grad u nizu
            tour(ia,newcity)=tour(ia,iq);
            tour(ia,iq)=temp;
              
              end
            
            phmone(tour(ia,iq-1),tour(ia,iq))=(1-0.1)*phmone(tour(ia,iq-1),tour(ia,iq))+0.1*(1/(nn_len*Ncity));
              
           end % iq
        
    
    end
       
    
    
    % ra�unamo duljinu svake ture i distribuciju feromona
  for ic=1:Nants
        dist(ic,1)=0;
        for id=1:Ncity
            dist(ic,1)=dist(ic)+dcity(tour(ic,id),tour(ic,id+1));
           
        end % id
 end % ic
    
    [dmin,ind]=min(dist);
    if (dmin<dbest)
        dbest=dmin;
        tura=tour(ind,:);
        best_it=it;
    end % if
    % feromoni za elitni put
    ph1=zeros(Ncity,Ncity);
    for id=1:Ncity
        ph1(tour(ind,id),tour(ind,id+1))=Q/dbest;
    end % id
    % obnavljanje(isparavanje i poja�avanje) feromonskih tragova
    phmone=(1-rr)*phmone+rr*ph1;
    dd(it,:)=[dbest dmin];
%    [it dmin dbest]
end %it
[tura;xcity(tura);ycity(tura)]'


axis square
figure(1);
plot(1:maxit,dd(:,1),'r-')
hold on
plot(1:maxit,dd(:,2),'-')
xlabel('Iteracija')
ylabel('Duljina ture')
title('Napredak algoritma na problemu trgova�kog putnika')
legend('Duljina globalno najkra�e ture','Duljina najkra�e ture u iteraciji')
hold off

figure(2);
labels = cellstr( num2str(tura') );
plot(xcity(tura),ycity(tura),xcity,ycity,'r.')
title('Rje�enje problema trgova�kog putnika dobiveno algoritmom')
text(xcity(tura),ycity(tura), labels,'HorizontalAlignment','left')





    

