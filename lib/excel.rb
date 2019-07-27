#require 'win32ole-ext'

module Excel

  def Excel.new(visible = false, displayAlerts = false)
#    excel = WIN32OLE.new_with_const('Excel.Application', Excel)
#    excel.visible = visible
#    excel.displayAlerts = displayAlerts
#    return excel
  end

  def Excel.runDuring(visible = false, displayAlerts = false, &block)
    begin
      excel = new(visible, displayAlerts)
      block.call(excel)
    ensure
#      excel.quit
    end
  end

end
