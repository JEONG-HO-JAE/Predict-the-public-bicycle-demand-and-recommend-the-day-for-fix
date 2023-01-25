factors = [ "bicycle.xlsx" "bus.xlsx" "people.xlsx" "subway.xlsx" "traffic.xlsm" ];

%% 따릉이와 변수를 월단위(행), 자치구단위(열) 로 불러온다.
[bicycle_, factor_, districts] = bicycle(factors(1), factors(4));

%% 함수 피팅을 진행한다. 
% 훈련: 2018년 1월 ~ 2020년 11월까지 총 35개월치
[net, tr] = fitting(bicycle_(1:end-1,:), factor_(1:end-1,:));

%% 테스팅, 2018년 2월 ~ 2020년 12월 생활인구 자료를 가지고 진행.
test_case = factor_(2:end,:);
prediction = real_value_prediction(net, test_case);

%% 실제 값과 비교해보자.
size_ = size(prediction, 2);
figure(1); 
plot(1:size_, bicycle_(end,:), 'red');
hold on
plot(1:size_, prediction(end,:), 'blue');
%bar(1:size_, prediction - bicycle_(end,:), 'green');

legend('bicycle', 'prediction');
hold off
