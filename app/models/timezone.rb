class Timezone  
  def Timezone.search term
    ret = []
    TZInfo::Timezone.all.map do |tz|
      ret << { 
      	label: tz.friendly_identifier(true), 
      	value: tz.current_period.utc_total_offset
      } if tz.name.downcase.include? term.downcase
    end
    ret
  end
end
