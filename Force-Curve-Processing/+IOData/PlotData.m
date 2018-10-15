function handles = PlotData(LineData, handles)
% PLOTDATA plot prior extracted data via ExtractPlotData according to
% setting in FCProcessing

%% preparation
trace_x = [];
trace_y = [];
retrace_x = [];
retrace_y = [];

if ~isempty(handles.guiprops.MainAxes)
    ax = handles.guiprops.MainAxes;
    delete(allchild(ax));
else
    note = 'No open Main Graph Window';
    HelperFcn.ShowNotification(note);
    return
end


%% setup plot

% prepare data for axis labeling
curvename = handles.guiprops.Features.edit_curve_table.UserData.CurrentCurveName;
xchannel_val = handles.guiprops.Features.curve_xchannel_popup.Value;
ychannel_val = handles.guiprops.Features.curve_ychannel_popup.Value;
if ~isempty(curvename)
    if ~isempty(handles.curveprops.(curvename).RawData.SpecialInformation)
        info = handles.curveprops.(curvename).RawData.SpecialInformation.Segment1;
        if ~isempty(info.columns) && ~isempty(info.units)
            channels = info.columns;
            units = info.units;
        else
            CurveData = handles.curveprops.(curvename).RawData.CurveData;
            segments = fieldnames(CurveData);
            channels = fieldnames(CurveData.(segments{1}));
            units = cell(length(channels), 1);
            for i = 1:length(channels)
                units{i} = 'unknown';
            end
        end
    else % EasyImport is true --> CurveData is just a matrix with numerical data
        CurveData = handles.curveprops.(curvename).RawData.CurveData;
        sz = size(CurveData);
        channels = cell(sz(2), 1);
        units = cell(sz(2), 1);
        for i = 1:sz(2)
            channels{i} = ['Channel ' num2str(i)];
            units{i} = 'unknown';
        end
    end
end

% ax = handles.guiprops.MainAxes;
% delete(allchild(ax));

% prepare plot data
if ~isempty(LineData.Trace)
    segment = fieldnames(LineData.Trace);
    for i = 1:length(segment)
        if ~isempty(LineData.Trace.(segment{i}).XData) && ...
                ~isempty(LineData.Trace.(segment{i}).YData)
            trace_x = [trace_x; LineData.Trace.(segment{i}).XData];
            trace_y = [trace_y; LineData.Trace.(segment{i}).YData];
        else
            trace_x = [];
            trace_y = [];
        end
    end
end

if ~isempty(LineData.Retrace)
    segment = fieldnames(LineData.Retrace);
    for i = 1:length(segment)
        if ~isempty( LineData.Retrace.(segment{i}).XData) && ...
                ~isempty(LineData.Retrace.(segment{i}).YData)
            retrace_x = [retrace_x; LineData.Retrace.(segment{i}).XData];
            retrace_y = [retrace_y; LineData.Retrace.(segment{i}).YData];
        else
            retrace_x = [];
            retrace_y = [];
        end
    end
end

% convert trace from cell to mat if necessary
if isa(trace_x, 'cell') 
    trace_x = cell2mat(trace_x);
end
if isa(trace_y, 'cell')
    trace_y = cell2mat(trace_y);
end

% convert retrace from cell to mat if necessary
if isa(retrace_x, 'cell')
    retrace_x = cell2mat(retrace_x);
end
if isa(retrace_y, 'cell')
    retrace_y = cell2mat(retrace_y);
end

% plot trace and retrace
if ~isempty(trace_x) && ~isempty(trace_y)
    trace = line(ax, trace_x, trace_y);
    trace.Color = handles.curveprops.TraceColor;
    trace.DisplayName = 'Trace';
end

if ~isempty(retrace_x) && ~isempty(retrace_y)
    retrace = line(ax, retrace_x, retrace_y);
    retrace.Color = handles.curveprops.RetraceColor;
    retrace.DisplayName = 'Retrace';
end

ax.XGrid = 'on';
ax.YGrid = 'on';
ax.XMinorGrid = 'on';
ax.YMinorGrid = 'on';
ax.XLabel.String = [channels{xchannel_val} ' / ' units{xchannel_val}];
ax.YLabel.String = [channels{ychannel_val} ' / ' units{ychannel_val}];

guidata(handles.figure1, handles);