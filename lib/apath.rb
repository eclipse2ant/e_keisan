module Apath
  def apath(file)
    File.expand_path(file,ENV['E_KEISAN'])
  end
end
