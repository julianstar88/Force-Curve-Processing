function SettingsYchannelCallback(src, evt)

    % handles and results-object
    main = findobj(allchild(groot), 'Type', 'Figure', 'Tag', 'figure1');
    handles = guidata(main);
    results = getappdata(handles.figure1, 'VerticalTipPosition');
    
    results.settings_ychannel_popup_value = src.Value;
    
    % write handles and results
    setappdata(handles.figure1, 'VerticalTipPosition', results);
    guidata(handles.figure1, handles);
    results.FireEvent('UpdateObject');

end % SettingsYchannelCallback

