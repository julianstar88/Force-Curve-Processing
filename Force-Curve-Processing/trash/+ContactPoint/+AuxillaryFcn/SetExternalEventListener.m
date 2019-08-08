function SetExternalEventListener(varargin)
%SETEXTERNALEVENTLISTENER Listener for external Events
%   Sets the property event listener neccessary to keep the graphical input
%   and output elemnts updated. This Listener objects listen to changes of
%   properties in the results-object of each editfunction.

    % handles and results-object
    [~, handles, results] = UtilityFcn.GetCommonVariables('ContactPoint');
    
    % do stuff
    
    % update handles and results-object
    UtilityFcn.PublishResults('ContactPoint', handles, results);

end % SetExternalEventListener
