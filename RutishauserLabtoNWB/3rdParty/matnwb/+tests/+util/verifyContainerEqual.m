function verifyContainerEqual(testCase, actual, expected)
testCase.verifyEqual(class(actual), class(expected));
props = properties(actual);
for i = 1:numel(props)
    prop = props{i};
    val1 = actual.(prop);
    val2 = expected.(prop);
    failmsg = ['Values for property ''' prop ''' are not equal']; 

    if startsWith(class(val1), 'types.') && ~startsWith(class(val1), 'types.untyped')
        tests.util.verifyContainerEqual(testCase, val1, val2);
    elseif isa(val1, 'types.untyped.Set')
        tests.util.verifySetEqual(testCase, val1, val2, failmsg);
    elseif isdatetime(val1)
        testCase.verifyTrue(isdatetime(val2));
        testCase.verifyEqual(char(val1), char(val2), failmsg);
    else
        if isa(val1, 'types.untyped.DataStub')
            trueval = val1.load();
        else
            trueval = val1;
        end
        testCase.verifyEqual(trueval, val2, failmsg);
    end
end
end