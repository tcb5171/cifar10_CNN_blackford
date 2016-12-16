clear
clc

load('zact.mat')
load('zprob.mat')
load('zrecog.mat')
anal=zeros(10,10);

for j=1:10
    for k=1:10
           anal(j,k)=length(find(zRecog==k & zActual==j)) ;
    end
end
figure(1)
mean=mean(mean(anal));
std=std(std(anal));
rotate3d on
%analZ=(anal-mean)./std;
surf(anal)
%%

for i=1:10
accuracy(i)=100*anal(i,i)/(sum(anal(i,:))+sum(anal(:,i)));
end

figure(2)
bar(accuracy)
xlabel('Class Label')
ylabel('Accuracy')
title('Classification Rate')
label={'airplane','automobile','bird','cat','deer','dog','frog','horse','ship','truck'};
set(gca,'xticklabel',label)

%%
sortedAnal=fliplr(sort(anal,2))';

for j=1:10
for i=1:10
    topk(j,i)=sum(sortedAnal(1:i,j));        
end
end

for j=1:10
for i=1:10 
    topk(i,j)=topk(i,j)/max(topk(i,:));
end
end

figure(3)
plot(topk');
legend('airplane','automobile','bird','cat','deer','dog','frog','horse','ship','truck');
xlabel('K=')
ylabel('accuracy')
title('Top-K ranked classed')
axis([1 10 .2 1])
