function [bicycle_, factor_, districts] = bicycle(bicycle_file, factor_file)
%% 2018년 1월부터 2020년 12월까지 총 36개월 * 25자치구 행렬을 만든다.
bicycle_=[];
factor_=[];
sheets = ["2018년" "2019년" "2020년"];
districts = ["gangnam", "gangdong", "gangbuk", "gangseo", "gwanak", "gwangjin", "guro", "geumcheon", "nowon", "dobong", "dongdaemun", "dongjak", "mapo", "seodaemun", "seocho", "sungdong", "sungbuk", "songpa", "yangcheon", "yeongdeungpo", "youngsan", "eunpyeong", "jongno", "junggu", "jungnang"];

for i = 1:size(sheets,2)
    opts = spreadsheetImportOptions("NumVariables", 25);
    % 시트와 범위 지정
    opts.Sheet = sheets(i);
    opts.DataRange = 'B4:Z15';

    % 열 이름과 유형 지정
    opts.VariableNames = districts;
    opts.VariableTypes = ["double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double"];

    % 데이터 가져오기
    bicycle_temp = readtable(bicycle_file, opts, 'UseExcel', false);
    factor_temp = readtable(factor_file, opts, 'UseExcel', false);

    % 데이터 변환하기
    bicycle_ = [bicycle_; table2array(bicycle_temp)];
    factor_ = [factor_; table2array(factor_temp)];
end

%% 실제값 -> 자치구별 퍼센트로 전환
sum_bicycle = sum(bicycle_, 2);
sum_factor = sum(factor_, 2);
for i = 1:size(bicycle_, 1)
    bicycle_(i,:) = (bicycle_(i,:) ./ sum_bicycle(i) ) * 100;
    factor_(i,:) = (factor_(i,:) ./ sum_factor(i)) * 100;
end
% clear unused
clear bicycle_temp, clear factor_temp, clear opts, clear i, clear sheets;
end