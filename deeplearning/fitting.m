function [net, tr] = fitting(bicycle_, factor_)
% 입력 벡터와 목표 벡터를 작업공간에 불러온다.
inputs = factor_;
targets = bicycle_;

% 함수 피팅에 대한 신경망 `fitnet` 을 정의한다.
hiddenLayerSize = 50;
net = fitnet(hiddenLayerSize);
net.divideParam.trainRatio = 70/100;
net.divideParam.valRatio = 15/100;
net.divideParam.testRatio = 15/100;

% 신경망 훈련. 'trainlm', 'trainbr', 'trainscg'가 있다.
net.trainFcn = 'trainlm';
[net, tr] = train(net, inputs, targets);

% clear unused
clear inputs, clear targets, clear hiddenLayerSize;
end

