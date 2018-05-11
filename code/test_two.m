% Grab single f(t) feature for each song
% Train NN using feature
% Target is f(g) - straight line (in one of 4 dims) where g is the genre.
clear; clc();
delay = 20;
neurons = 10;
algo = "trainlm";
TDNN = timedelaynet((0:delay), neurons, char(algo));
            TDNN.trainParam.showWindow = false;
            TDNN.trainParam.showCommandLine = true;

% Genres:
a = [1;0;0;0];
b = [0;1;0;0];
c = [0;0;1;0];
d = [0;0;0;1];

% song = zeros(3, 1000);
song(1,:) = test_get_feature(1, 1);
song(2,:) = test_get_feature(2, 1);
song(3,:) = test_get_feature(3, 1);
song(4,:) = test_get_feature(4, 1);

%  Create training set and targets
len=250;
input = [song(2,1:len), song(3,1:len), song(1,1:len), song(4,1:len)];
trainIn = tonndata(input, true, false);

target = [repmat( b,1,len ),repmat( c,1,len ),repmat( a,1,len ), repmat(d,1,len)];
trainTarget = tonndata( target, true, false); 

[Xs,Xi,Ai,Ts] = preparets(TDNN,trainIn, trainTarget);
TDNN = train(TDNN,Xs, Ts, Xi, Ai);


testB = tonndata(song(2,1:len), true, false);
nnOutput = TDNN(testB);

mat = cell2mat(nnOutput);
predicc{2} = mean(mat,2);

testA = tonndata(song(1,1:len),true,false);
nnOutput = TDNN(testA);

mat = cell2mat(nnOutput);
predicc{1} = mean(mat,2);

testC = tonndata(song(3,1:len),true,false);
nnOutput = TDNN(testC);

mat = cell2mat(nnOutput);
predicc{3} = mean(mat,2);

testD = tonndata(song(4,1:len),true,false);
nnOutput = TDNN(testD);

mat = cell2mat(nnOutput);
predicc{4} = mean(mat,2);
