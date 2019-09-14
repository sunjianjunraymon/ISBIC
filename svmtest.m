clear;
clc;
close all

a=load('otraind.txt');
b=load('otestd.txt');

data=a(:,2:end);
groups=a(:,1);

tdata=b(:,2:end);
tgroups=b(:,1);
smotedata=load('otraindsmote.txt');
sf=smotedata(:,2:end);
sl=smotedata(:,1);

interpolatedata=load('otraindinterpolate.txt');
chazhif=interpolatedata(:,2:end);
chazhil=interpolatedata(:,1);

Struct1 = svmtrain(data,groups,'Kernel_Function','rbf', 'RBF_Sigma',0.81,'showplot',false);
classes1=svmclassify(Struct1,tdata,'showplot',false);
accuracy1=sum(tgroups==classes1)/length(tgroups)
tn=0; 
tp=0;
fn=0;
fp=0;
for i=1:length(tgroups)
    if(tgroups(i)==-1)&&(classes1(i)==-1)
    tn=tn+1;
    elseif (tgroups(i)==1)&&(classes1(i)==1)
    tp=tp+1;
    elseif (tgroups(i)==1)&&(classes1(i)==-1)
    fn=fn+1;
    else
    fp=fp+1;
    end
end
sensitivity1=tp/(tp+fn)
specifity1=tn/(tn+fp)

Struct2 = svmtrain(sf,sl,'Kernel_Function','rbf', 'RBF_Sigma',0.81,'showplot',false);
classes2=svmclassify(Struct2,tdata,'showplot',false);
accuracy2=sum(tgroups==classes2)/length(tgroups)
tn=0; 
tp=0;
fn=0;
fp=0;
for i=1:length(tgroups)
    if(tgroups(i)==-1)&&(classes2(i)==-1)
    tn=tn+1;
    elseif (tgroups(i)==1)&&(classes2(i)==1)
    tp=tp+1;
    elseif (tgroups(i)==1)&&(classes2(i)==-1)
    fn=fn+1;
    else
    fp=fp+1;
    end
end
sensitivity2=tp/(tp+fn)
specifity2=tn/(tn+fp)


Struct3 = svmtrain(chazhif,chazhil,'Kernel_Function','rbf', 'RBF_Sigma',0.81,'showplot',false);
classes3=svmclassify(Struct3,tdata,'showplot',false);
accuracy3=sum(tgroups==classes3)/length(tgroups)
tn=0; 
tp=0;
fn=0;
fp=0;
for i=1:length(tgroups)
    if(tgroups(i)==-1)&&(classes3(i)==-1)
    tn=tn+1;
    elseif (tgroups(i)==1)&&(classes3(i)==1)
    tp=tp+1;
    elseif (tgroups(i)==1)&&(classes3(i)==-1)
    fn=fn+1;
    else
    fp=fp+1;
    end
end
sensitivity3=tp/(tp+fn)
specifity3=tn/(tn+fp)



r1=[accuracy1 sensitivity1  specifity1]
r2=[accuracy2 sensitivity2  specifity2]
r3=[accuracy3 sensitivity3  specifity3]
