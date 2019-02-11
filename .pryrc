instance_eval do
  def shrink_object_name(name)
    splitted = name.to_s.split('::')
    return name if splitted.count < 4

    "#{splitted[0]}::…::#{splitted[-1]}"
  end

  logo = Pry::Helpers::Text.green(Pry::Helpers::Text.bold('λ'))
  Pry.config.prompt = lambda do |obj, nest_level, _|
    obj_name_shrunk = shrink_object_name(obj)
    "[#{nest_level}](#{obj_name_shrunk}) #{logo} "
  end
end
