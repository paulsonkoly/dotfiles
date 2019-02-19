instance_eval do
  def shrink_object_name(name)
    splitted = name.to_s.split('::')
    splitted.map! { |split| split.gsub(/0x(\h)\h{14}(\h)/, '0x\1…\2') }

    if splitted.count <= 4
      splitted.join('::')
    else
    "#{splitted[0]}::…::#{splitted[-1]}"
    end
  end

  logo = Pry::Helpers::Text.green(Pry::Helpers::Text.bold('λ'))
  Pry.config.prompt = lambda do |obj, nest_level, _|
    obj_name_shrunk = shrink_object_name(obj)
    "[#{nest_level}](#{obj_name_shrunk}) #{logo} "
  end
end
