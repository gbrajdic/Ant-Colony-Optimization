
choice1 = menu('Izaberite TSP problem kojeg želite rješavati','Burma 14','Ulysses 16','Ulysses 22','Oliver30','Att 48','Berlin 52','Eil 76','St 70','Pr 76','Ch 130');

choice2 = menu('Izaberite željeni ACO-algoritam','Ant System','Elitist Ant System','Rank-based ant system','Max-Min ant system','Ant colony system');

cities1=load('burma14_data.txt');
cities2=load('oliver30_data.txt');
cities3=load('berlin52_data.txt');
cities4=load('eil76_data.txt');
cities5=load('att48_data.txt');
cities6=load('ulysses16_data.txt');
cities7=load('ulysses22_data.txt');
cities8=load('pr76_data.txt');
cities9=load('st70_data.txt');
cities10=load('ch130_data.txt');

if (choice1==1)
    city=cities1;
else if (choice1==2)
        city=cities6;
    else if (choice1==3)
            city=cities7;
        else
            if(choice1==4)
                city=cities2;
            else if (choice1==5)
                    city=cities5;
                else if (choice1==6)
                        city=cities3;
                    else if (choice1==7)
                        city=cities4;
                        else if (choice1==8)
                                city=cities8;
                            else if (choice1==9)
                                    city=cities9;
                                else 
                                    city=cities10;
                                end
                            end
                        end
                    end
                end
            end
            
        end
    end
end

answer=0;

len=length(city);

if(choice2==1)

    prompt={'Broj mravi:','Parametar feromona(alfa>0)','Parametar heuristièke informacije(beta>0):','Parametar brzine isparavanja(0-1):','Broj iteracija algoritma'};
    name='Izaberite sljedeæe parametre algoritma';
    numlines=1;
    defaultanswer={num2str(len),'1','5','0.1','100'};
    answer=inputdlg(prompt,name,numlines,defaultanswer, 'on');
    [dbest,best_it]=TSP_AS_ACO(city,str2num(answer{1}),str2num(answer{2}),str2num(answer{3}),str2num(answer{4}),1,str2num(answer{5}));
     Title ='Izvještaj algoritma';
     Message={['Najkraæa tura dobivena algoritmom Ant System iznosi: ', num2str(dbest)],['Iteracija u kojoj je pronaðena najkraæa tura: ' num2str(best_it)]};
     msgbox(Message,Title)
    
else
    if(choice2==2)
        
    prompt={'Broj mravi:','Parametar feromona(alfa>0)','Parametar heuristièke informacije(beta>0):','Parametar brzine isparavanja(0-1):','Težina elitnog puta','Broj iteracija algoritma'};
    name='Izaberite sljedeæe parametre algoritma';
    numlines=1;
    defaultanswer={num2str(len),'1','5','0.1',num2str(len),'100'};
    answer=inputdlg(prompt,name,numlines,defaultanswer,'on');
    [dbest,best_it]=TSP_elit_ACO(city,str2num(answer{1}),str2num(answer{2}),str2num(answer{3}),str2num(answer{4}),str2num(answer{5}),1,str2num(answer{6}));
    Title ='Izvještaj algoritma';
    Message={['Najkraæa tura dobivena algoritmom Elitist Ant System iznosi: ', num2str(dbest)],['Iteracija u kojoj je pronaðena najkraæa tura: ' num2str(best_it)]};
    msgbox(Message,Title)
    else
        if (choice2==3)
            
       
                prompt={'Broj mravi:','Parametar feromona(alfa>0)','Parametar heuristièke informacije(beta>0):','Parametar brzine isparavanja(0-1):','Broj mravi koji æe ažurirati feromone','Broj iteracija algoritma'};
                name='Izaberite sljedeæe parametre algoritma';
                numlines=1;
                defaultanswer={num2str(len),'1','5','0.1','6','100'};
                answer=inputdlg(prompt,name,numlines,defaultanswer,'on');
                [dbest,best_it]=TSP_Rank_ACO(city,str2num(answer{1}),str2num(answer{2}),str2num(answer{3}),str2num(answer{4}),str2num(answer{5}),1,str2num(answer{6}));
                Title ='Izvještaj algoritma';
                Message={['Najkraæa tura dobivena algoritmom Rank-based Ant System iznosi: ', num2str(dbest)],['Iteracija u kojoj je pronaðena najkraæa tura: ' num2str(best_it)]};
                msgbox(Message,Title)
        else
                if(choice2==4)
                    
                    prompt={'Broj mravi:','Parametar feromona(alfa>0)','Parametar heuristièke informacije(beta>0):','Parametar brzine isparavanja(0-1):','Broj iteracija algoritma'};
                    name='Izaberite sljedeæe parametre algoritma';
                    numlines=1;
                    defaultanswer={num2str(len),'1','5','0.02','100'};
                    answer=inputdlg(prompt,name,numlines,defaultanswer,'on');
                    [dbest,best_it]=TSP_MMAS_ACO(city,str2num(answer{1}),str2num(answer{2}),str2num(answer{3}),str2num(answer{4}),1,1,str2num(answer{5}));
                    Title ='Izvještaj algoritma';
                    Message={['Najkraæa tura dobivena algoritmom Max-Min Ant System iznosi: ', num2str(dbest)],['Iteracija u kojoj je pronaðena najkraæa tura: ' num2str(best_it)]};
                    msgbox(Message,Title)
                else
                    
                    
                    prompt={'Broj mravi:','Parametar feromona(alfa>0)','Parametar heuristièke informacije(beta>0):','Parametar brzine isparavanja(0-1):','Parematar eksploracije(0-1)','Broj iteracija algoritma'};
                    name='Izaberite sljedeæe parametre algoritma';
                    numlines=1;
                    defaultanswer={num2str(len),'1','2','0.1','0.7','100'};
                    answer=inputdlg(prompt,name,numlines,defaultanswer,'on');
                    [dbest,best_it]=TSP_ACS_ACO(city,str2num(answer{1}),str2num(answer{2}),str2num(answer{3}),str2num(answer{4}),str2num(answer{5}),1,str2num(answer{6}));
                    Title ='Izvještaj algoritma';
                    Message={['Najkraæa tura dobivena algoritmom Ant Colony System iznosi: ', num2str(dbest)],['Iteracija u kojoj je pronaðena najkraæa tura: ' num2str(best_it)]};
                    msgbox(Message,Title)
                end
        end
    end
end

                    
                    