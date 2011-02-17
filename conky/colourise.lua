-- based on the conky config posted by Foucault on the Arch Linux forums

do
	local cool = "88CC00"
	local medi = "DDDD00"
	local hot = "EE5555"
	function conky_colorise_cpu(arg)
		-- arg is which cpu
		local color = "000000"
		local perc = tonumber(conky_parse(string.format('${cpu cpu%i}',tonumber(arg))))
		if perc == nil then
			perc = -1
		end
		if perc <= 25 then
			color = cool
		elseif perc > 25 and perc < 80 then
			color = medi
		else
			color = hot
		end
		return string.format('${color %s}%3i%%${color}',color,tonumber(perc))
		
	end

	function conky_format_speeds(arg)
		downvalue = tonumber(conky_parse(string.format('${downspeedf %s}',arg)))
		upvalue   = tonumber(conky_parse(string.format('${upspeedf %s}',arg)))
		return string.format('${color %s}%5.0fkB/s${color} ${color %s}%5.0fkB/s${color}',cool,downvalue,hot,upvalue)
	end

	function conky_colorise_mem(arg)
		local color = "000000"
		local perc = tonumber(conky_parse(string.format('${memperc}')))
		if perc == nil then
			perc = -1
		end
		if perc <= 25 then
			color = cool
		elseif perc > 25 and perc < 80 then
			color = medi
		else
			color = hot
		end
		return string.format('${color %s}%s${color}/%s (${color %s}%3i%%${color})',
			color,'${mem}','${memmax}',color,tonumber(perc)
		)
		
	end

	function conky_weight_frequency(arg)
		local freqs = {}
		local max = 0
		for i=1,tonumber(arg) do
			freqs[i] = tonumber(conky_parse(string.format('${freq_g %s}',arg)))
			if freqs[i] > max then
				max = freqs[i]
			end
		end
		return string.format('%3.1f GHz',max)
	end

	function conky_colorise_temps(what_, min__, max__)
		local color = "000000"
		local min_ = tonumber(min__)
		local max_ = tonumber(max__)
		what_ = string.format('${%s}',string.gsub(what_,"+"," "))
		local what = tonumber(conky_parse(string.format('%s',what_)))
		if tonumber(what) <= (min_ + 0.25*(max_-min_)) then
			color = cool
		elseif tonumber(what) > (min_ + 0.25*(max_-min_)) and
				tonumber(what) < (min_ + 0.80*(max_-min_)) then
			color = medi
		else
			color = hot
		end
		return string.format('${color %s}%s°C${color}',color,what)
	end
end
