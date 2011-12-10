class Timezone  
  def Timezone.search term
    ret = []
    ActiveSupport::TimeZone.all.each do |tz|
      ret << { label: tz.name, value: tz.utc_offset } if tz.name.downcase.include? term.downcase
    end
    ret
  end
end
