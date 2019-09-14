%Affinity Propagation (APCLUSTER) sample/demo code 
clear;
clc;
close all;
a=load('otraind.txt');
N=size(a,1); x=a(:,2:end); M=N*N-N; s=zeros(M,3); j=1; 
for i=1:N 
      for k=[1:i-1,i+1:N] 
        s(j,1)=i; s(j,2)=k; s(j,3)=-sum((x(i,:)-x(k,:)).^2);%%????? 
        j=j+1; 
      end; 
end;  
p=median(s(:,3)); 

[idx]=apcluster(s,p); 
total=1:size(a,1);
xuhao={};
center=unique(idx);
nc=length(unique(idx)); 
for i=1:nc
  xuhao{i}=find(idx==center(i)); 
end; 

label=a(:,1);
bq=unique(label);
nm=length(find(label==bq(2)));
nb=length(find(label==bq(1)));
if nm>nb
    np=nm-nb;
    pl=bq(1);
else
    np=nb-nm;
    pl=bq(2);
end

one=1:4;
two=16:20;
three=[one two];
T=a(three,2:end);
k=5;
sample=mySMOTE2(T,0.8,k);

store=[];
for i=1:nc
   pos=xuhao{i};
  if (length(find(label(pos)==pl))>0.5*length(pos))&&(length(find(label(pos)==pl))>2*k)
     temp=[i length(find(label(pos)==pl))];
     store=[store; temp];
  end
end

radio=np/sum(store(:,2));
all=[];
for i=1:size(store,1)
    wz=store(i,1);  
    leineiyiersuoyin=xuhao{wz};
    three=[];
    for j=1:length(leineiyiersuoyin)
        if label(leineiyiersuoyin(j),1)==pl
            three=[three leineiyiersuoyin(j)];
        end
    end
    
    T=a(three,2:end);
    sample=mySMOTE2(T,radio,k);
    all=[all; sample];
end

allsyntheticsample=zeros(size(all,1),size(all,2)+1);
allsyntheticsample(:,1)=pl;
allsyntheticsample(:,2:end)=all;

fp=fopen('otraindsmote.txt','a');
for q = 1 : size(allsyntheticsample,1)
    fprintf(fp, '\r\n');
    fprintf(fp,'%d ',allsyntheticsample(q,:));
    
end
fclose(fp);
