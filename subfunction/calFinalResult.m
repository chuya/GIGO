function result=calFinalResult(vectors)
    featureSize = size(vectors,2);
    [topicList,weightsList] = getWeights(featureSize);
    topicList = unique(topicList);
    result = votes(vectors,weightsList,topicList);
end

function result = votes(vectors,weightsList,topicList)
    votesList = linspace(0,0,size(topicList,2));
    weightsNumber = size(weightsList,2);
    scoreList = linspace(0,0,size(topicList,2));
    for i = 1:weightsNumber
        v = vectors.*weightsList(i).weights;
        score = sum(v);
        score
        v = v/sqrt(weightsList(i).weights*weightsList(i).weights');
        score = sum(v);
        score
        if( strcmp(weightsList(i).typeA,'bottle') )
            if( strcmp(weightsList(i).typeB,'can') )
                score = score + 1.1159;
            elseif( strcmp(weightsList(i).typeB,'glass') )
                score = score - 0.3129;
            else
                score = score + 0.0916;
            end
        elseif( strcmp(weightsList(i).typeA,'can'))
            if( strcmp(weightsList(i).typeB,'glass') )
                score = score - 3.0753;
            else
                score = score - 1.5976;
            end
        elseif( strcmp(weightsList(i).typeA,'glass') )
            score = score + 0.064;
        end
        if(score < 0)
            ind = ismember(topicList,weightsList(i).typeA);
            votesList(ind) = votesList(ind) + 1;
            scoreList(ind) =  scoreList(ind) + score;
        else
            ind = ismember(topicList,weightsList(i).typeB);
            votesList(ind) = votesList(ind) + 1;
            scoreList(ind) =  scoreList(ind) + (-1)*score;
        end
    end
    [maxVote,index] = max(votesList);
%   if there are more than one members have max votes , enter specialCase   
    if( sum(ismember(votesList,maxVote)) > 1)
        fprintf('Enter Rand 2');
        maxMembers = ismember(votesList,maxVote);
        result =specialCase(topicList,scoreList,maxMembers);
    else
        result = char(topicList(index));
    end
    
end


function result = specialCase(topicList,scoreList,maxMembers)
    rand2List = topicList(maxMembers);
    rand2Score = scoreList(maxMembers);
    [~,winnerIndex] = max(rand2Score);
    result = char( rand2List(winnerIndex) );
end