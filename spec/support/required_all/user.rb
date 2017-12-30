class User
  def suspend!
    ConsoleNotifier.notify("suspended as")
  end
end
