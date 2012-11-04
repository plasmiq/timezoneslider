class Timezone  
  def Timezone.search term
    ret = []
    Timezoneslider::Geonames.each do |location|
      if location[0].downcase.include? term.downcase
        tz = TZInfo::Timezone.get( location[1] ) 
        elem = { 
      	  label: location[0], 
	  timezone: location[1],
      	  value: tz.current_period.utc_total_offset
        } 
        ret << elem
      end
    end
    # limit results to 8
    ret[0..7]
  end
end
