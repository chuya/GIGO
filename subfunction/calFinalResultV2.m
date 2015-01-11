function result=calFinalResultV2(vectors)
    topicList ={'bottle' 'can' 'glass' 'pak'};
    featureSize = size(vectors,2);
    result = getWeightsV2(vectors);
%     result = char(topicList(index));
end




function result = getWeightsV2(vector)
    if( vector(117) <= 0.67481 )
        if( vector(235) <= 0.001013 )
            if( vector(174) <= 0.002299 )
                if( vector(246) <= 0.001248 )
                    if( vector(102) <= 0.42427 )
                        result='bottle';
                    else
                        if( vector(72) <= 0.3903 )
                            if( vector(366) <= 0.001181 )
                                result='bottle';
                            else
                                result='pak';
                            end
                        else
                            if( vector(164) <= 3.0679 )
                                if( vector(148) <= 1.639 )
                                    if( vector(33) <= 0.58585 )
                                        if( vector(96) <= 0.38542 )
                                            result='bottle';
                                        else
                                            result='pak';
                                        end
                                    else
                                        result='bottle';
                                    end
                                else
                                    result='pak';
                                end
                            else
                                result='can';
                            end
                        end
                    end
                else
                    result='can';
                end
            else
                result='bottle';
            end
        else
            result='can';
        end
    else
        if( vector(363) <= 0.002801 )
            if( vector(172) <= 2.2817 )
                if( vector(353) <= 0.002086 )
                    if( vector(225) <= 0 )
                        if( vector(19) <= 0.35001 )
                            result='can';
                        else
                            if( vector(246) <= 0.004843 )
                                if( vector(164) <= 0.91407 )
                                    if( vector(345) <= 0.001046 )
                                        if( vector(118) <= 0.62478 )
                                            if( vector(49) <= 0.63239 )
                                                result='can';
                                            else
                                                result='bottle';
                                            end
                                        else
                                            result='bottle';
                                        end
                                    else
                                        result='can';
                                    end
                                else
                                    if( vector(370) <= 0.008152 )
                                        if( vector(370) <= 0.006088 )
                                            if( vector(90) <= 0.58753 )
                                                if( vector(194) <= 0.003311 )
                                                    if( vector(217) <= 0.001146 )
                                                        if( vector(72) <= 0.38979 )
                                                            if( vector(19) <= 0.35309 )
                                                                result='glass';
                                                            else
                                                                result='bottle';
                                                            end
                                                        else
                                                            result='glass';
                                                        end
                                                    else
                                                        result='bottle';
                                                    end
                                                else
                                                    result='glass';
                                                end
                                            else
                                                result='glass';
                                            end
                                        else
                                            result='pak';
                                        end
                                    else
                                        result='glass';
                                    end
                                end
                            else
                                result='can';
                            end
                        end
                    else
                        result='can';
                    end
                else
                    result='can';
                end
            else
                if( vector(90) <= 0.58753 )
                    result='can';
                else
                    result='glass';
                end
            end
        else
            result='pak';
        end
    end
end