function CellSelectionCallback(src, evt, handles)
%CELLEDITCALLBACK Summary of this function goes here

if ~isempty(evt.Indices)
    
    % activating all connected listeners to UpdateObject-Event
    handles.guiprops.FireEvent('UpdateObject');
    
    % determine curvename
    row = evt.Indices(1, 1);
    curvename = src.Data{row, 1};
    
    % Update handles.curveprops.curvename.Results-property with
    % edit_functions
    dynprops = handles.curveprops.(curvename).Results.DynamicProps;
    if ~isempty(handles.procedure.DynamicProps) && isempty(dynprops)
        handles = HelperFcn.AddFunctionsToCurve(handles);
    end
    
    % update specific guiprops and curveprops properties
    src.UserData.CurrentRowIndex = row;
    src.UserData.CurrentRowSpan = [evt.Indices(1, 1); evt.Indices(end, 1)];
    src.UserData.CurrentCurveName = curvename;
    xch_idx = handles.guiprops.Features.curve_xchannel_popup.Value;
    ych_idx = handles.guiprops.Features.curve_ychannel_popup.Value; 

    [LineData, handles] = UtilityFcn.ExtractPlotData(handles.curveprops.(curvename).RawData, handles,...
        xch_idx,...
        ych_idx);
    handles = IOData.PlotData(LineData, handles);
end
guidata(handles.figure1, handles);


