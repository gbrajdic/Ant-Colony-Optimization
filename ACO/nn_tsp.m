
% Algoritam najbližeg susjeda za problem trgovaèkog putnika
% Služi nam prvenstveno kako bi na brzi naèin dobili kakvo-takvo rješenje
% od kojeg æe mravi graditi bolje 


function [shortestPathLength,shortestPath] = nn_tsp(cities)

% cities - vektor koji sadrži koordinate gradova
% shortestPath - najkraæa staza (tura)
% shortestPathLength - najmanja duljina ture pronaðena algoritmom

N_cities = size(cities,1);

distances = pdist(cities);
distances = squareform(distances);
distances(distances==0) = realmax;

shortestPathLength = realmax;

for i = 1:N_cities
    
    startCity = i;

    path = startCity;
    
    distanceTraveled = 0;
    distancesNew = distances;
    
    currentCity = startCity; 
    
    for j = 1:N_cities-1
        
        [minDist,nextCity] = min(distancesNew(:,currentCity));
        if (length(nextCity) > 1)
            nextCity = nextCity(1);
        end
        
        path(end+1,1) = nextCity;
        distanceTraveled = distanceTraveled +...
                    distances(currentCity,nextCity);
        
        distancesNew(currentCity,:) = realmax;
        
        currentCity = nextCity;
        
    end
    
    path(end+1,1) = startCity;
    distanceTraveled = distanceTraveled +...
        distances(currentCity,startCity);
    
    if (distanceTraveled < shortestPathLength)
        shortestPathLength = distanceTraveled;
        shortestPath = path; 
    end 
    
end
















