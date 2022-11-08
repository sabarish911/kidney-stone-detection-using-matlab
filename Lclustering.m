function [AA1, AA2, AA3, AA4] = Lclustering(Input1,Clusters)
load finval finval
for i=1:16
%     subplot(4,4,i); 
    blknam=strcat(num2str(i),'.jpg');
    cd datafin
    immg2(:,:,i)=imread(blknam);
    cd ..
end
k=0;
cata=Input1/sum(sum(sum(Input1)));
cd datafin
% if isequal(cout,2) 
for  m =1:128:512
    for n=1:128:512
        k=k+1;
        blknam=strcat(num2str(k),'.jpg');
        a(m:m+127,n:n+127)=immg2(:,:,k);
    end
end
cd ..
% imshow(a);
Input=a;
Clusterfin=2;
[AA12, AA22,BinaryImage]=Lclusteringfin(a,Clusterfin);
[r c] = size(a);
Length  = r*c; 
wd1=r;
wd2=c;
Dataset = reshape(Input,[Length,1]);   %%%%%Reshape 2D Image to 1D Vectors 
    
Cluster1=zeros(Length,1);
Cluster2=zeros(Length,1);
Cluster3=zeros(Length,1);
Cluster4=zeros(Length,1);

miniv = min(min(Input));      
maxiv = max(max(Input));
range = maxiv - miniv;
stepv = range/Clusters;
incrval = stepv;

for i = 1:Clusters            %%%%Find the centroids to each Clusters
    K(i).centroid = incrval;
    incrval = incrval + stepv;
end

update1=0;
update2=0;
update3=0;
update4=0;

mean1=2;
mean2=2;
mean3=2;
mean4=2;

while  ((mean1 ~= update1) && (mean2 ~= update2) && (mean3 ~= update3) && (mean4 ~= update4))

mean1=K(1).centroid;
mean2=K(2).centroid;
mean3=K(3).centroid;
mean4=K(4).centroid;

for i=1:Length                     %%%%%%Find the distance between Each Pixel and Centroids 
    for j = 1:Clusters
        temp = Dataset(i);
        difference(j) = abs(temp-K(j).centroid);
    end
    [y,ind]=min(difference);     %%%%Group Pixels to Each Cluster Based on Minimum Distance
    
	if ind==1
        Cluster1(i)   =temp;
	end
    if ind==2
        Cluster2(i)   =temp;
    end
    if ind==3
        Cluster3(i)   =temp;
    end
    if ind==4
        Cluster4(i)   =temp;
    end
end

%%%%%UPDATE CENTROIDS
cout1=0;
cout2=0;
cout3=0;
cout4=0;

for i=1:Length
    Load1=Cluster1(i);
    Load2=Cluster2(i);
    Load3=Cluster3(i);
    Load4=Cluster4(i);
    
    if Load1 ~= 0
        cout1=cout1+1;
    end
    
    if Load2 ~= 0
        cout2=cout2+1;
    end
    
    if Load3 ~= 0
        cout3=cout3+1;
    end
    
    if Load4 ~= 0
        cout4=cout4+1;
    end
end

Mean_Cluster(1)=sum(Cluster1)/cout1;
Mean_Cluster(2)=sum(Cluster2)/cout2;
Mean_Cluster(3)=sum(Cluster3)/cout3;
Mean_Cluster(4)=sum(Cluster4)/cout4;

for i = 1:Clusters
    K(i).centroid = Mean_Cluster(i);

end

update1=K(1).centroid;
update2=K(2).centroid;
update3=K(3).centroid;
update4=K(4).centroid;
end


AA1=reshape(Cluster1,[wd1 wd2]);
AA2=reshape(Cluster2,[wd1 wd2]);
AA3=reshape(Cluster3,[wd1 wd2]);
AA4=reshape(Cluster4,[wd1 wd2]);

figure('Name','Segmented Results');
subplot(2,2,1); imshow(AA1,[]);
subplot(2,2,2); imshow(AA2,[]);
subplot(2,2,3); imshow(AA3,[]);
subplot(2,2,4); imshow(AA4,[]);


    cd Clusim
    imwrite(AA1,'1.bmp');
    imwrite(AA2,'2.bmp');
    imwrite(AA3,'3.bmp');
    imwrite(AA4,'4.bmp');
    cd ..



return;
