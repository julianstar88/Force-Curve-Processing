function OffsetValueChangedCallback(src, evt, ohter_btn, property)
% OFFSETTILTVALUECHANGEDCALLBACK updates the correction_type property
% according to the the offset_radio_btn value
    
    %% create variables
    main = findobj(allchild(groot), 'Type', 'Figure', 'Tag', 'figure1');
    handles = guidata(main);
    table = handles.guiprops.Features.edit_curve_table;
    
    % abort if tabel is empty (means no curves loaded)
    if isempty(table.Data)
        return
    end
    
    curvename = table.UserData.CurrentCurveName;
    
    %% toggle like behavior of radio buttons
    if src.Value == 0
        ohter_btn.Value = 1;
        handles.curveprops.(curvename).Results.Baseline.(property) = 1;
    else
        ohter_btn.Value = 0;
        handles.curveprops.(curvename).Results.Baseline.(property) = 2;
    end
    
    %% update handles-struct
    guidata(handles.figure1, handles);
end

