% ULAZNI PARAMETRI 
% cities - koordinate gradova
% Nants - broj mravi
% a (alfa) - pozitivan parametar koji kontrolira relativnu važnost feromona
% b (beta) - pozitivan parametar koji kontrolira relativnu važnost heuristièke informacije
% rr - parametar brzine isparavanja feromona
% k - broj mravi koji æe obavaljati ažuriranje feromona
% Q - proizvoljna konstanta (obièno se postavlja na 1)
% maxit - maksimalan broj iteracija

% IZLAZNI PARAMETAR
% dbest - duljina najbolje pronaðene rute u maxit iteracija
% Algoritam dodatno ispisuje broj iteracije, najbolje rješenje u toj iteraciji i najbolje globalno rješenje 
% crta svoj napradak po iteracijama, te crta gradove povezane najboljom
% pronaðenom turom.

function [dbest,best_it]=TSP_Rank_ACO(cities,Nants,a,b,rr,k,Q,maxit)

if (Nants<k)
    k=Nants;
end

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

vis=1./dcity; % heuristièka informacija (inverz udaljenosti)
len_nn=nn_tsp(cities);
phmone=(0.5*(k+1)/k)/(rr*len_nn)*ones(Ncity,Ncity);% incicijalizacija feromona izmeðu gradova

dbest=9999999;
tour=zeros(Nants,Ncity);
dist=zeros(Nants,1);
dd=zeros(maxit,2);
% inicijaliziramo ture
for ic=1:Nants
    tour(ic,:)=randperm(Ncity);
end % ic
tour(:,Ncity+1)=tour(:,1); % tura završava u gradu u kojem poèinje
for it=1:maxit
    % tražimo turu po gradovima za svakog mrava
    % st je trenutni grad
    % nxt sadrži ostale gradove koje još treba posjetiti
    for ia=1:Nants
        for iq=2:Ncity-1
            st=tour(ia,iq-1); nxt=tour(ia,iq:Ncity);
            prob=((phmone(st,nxt).^a).*(vis(st,nxt).^b))./sum((phmone(st,nxt).^a).*(vis(st,nxt).^b));
            rcity=rand;
            for iz=1:length(prob)
                if (rcity<sum(prob(1:iz)))
                    newcity=iq-1+iz; % sljedeæi grad koji trebamo posjetiti
                    break
                end % if
            end % iz
            temp=tour(ia,newcity); % stavljamo novi grad u nizu
            tour(ia,newcity)=tour(ia,iq);
            tour(ia,iq)=temp;
        end % iq
    end % ia
    % raèunamo duljinu svake ture i distribuciju feromona
    phtemp=zeros(Ncity,Ncity);
    for ic=1:Nants
        dist(ic,1)=0;
        for id=1:Ncity
            dist(ic,1)=dist(ic)+dcity(tour(ic,id),tour(ic,id+1));
            phtemp(tour(ic,id),tour(ic,id+1))=0;
        end % id
    end % ic
    [dist_k_best,idx_k_best]=sort(dist);
    
    
    
    for ll=1:k
        for id=1:Ncity
        phtemp(tour(idx_k_best(ll),id),tour(idx_k_best(ll),id+1))=((k+1)-ll)*(Q/dist_k_best(ll,1));
        end
    end
    
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
    % obnavljanje(isparavanje i pojaèavanje) feromonskih tragova
    phmone=(1-rr)*phmone+phtemp+(k+1)*ph1;
    dd(it,:)=[dbest dmin];
   % [it dmin dbest]
end %it
[tura;xcity(tura);ycity(tura)]'



axis square
figure(1);
plot(1:maxit,dd(:,1),'r-')
hold on
plot(1:maxit,dd(:,2),'-')
xlabel('Iteracija')
ylabel('Duljina ture')
title('Napredak algoritma na problemu trgovaèkog putnika')
legend('Duljina globalno najkraæe ture','Duljina najkraæe ture u iteraciji')
hold off


figure(2);
labels = cellstr( num2str(tura') );
plot(xcity(tura),ycity(tura),xcity,ycity,'r.')
title('Rješenje problema trgovaèkog putnika dobiveno algoritmom')
text(xcity(tura),ycity(tura), labels,'HorizontalAlignment','left')














    

