require 'highline/import'

class AdagesController

  def index
    if Adage.count > 0
      adages = Adage.all
      choose do |menu|
        menu.prompt = ""
        adages.each do |adage|
          menu.choice(adage.content) { action_menu(adage) }
        end
        menu.choice("Exit")
      end
    else
      say("No adages were found here. If you are an old, wise dog, add some adages.\n")
    end
  end

  def advice
    adages = Adage.all.shuffle
    say("#{adages[0].content}")
  end

  def action_menu(adage)
    say("What would you like to do?")
    choose do |menu|
      menu.prompt = ""
      menu.choice("Edit this adage") do
        edit(adage)
      end
      menu.choice("Delete this adage") do
        destroy(adage)
      end
      menu.choice("Exit") do
        exit
      end
    end
  end

  def add(content)
    adage = Adage.new(content.strip)
    if adage.save
      "\"#{content}\" has been added!\n"
    else
      adage.errors.full_messages.join
    end
  end

  def edit(adage)
    loop do
      user_input = ask("Please enter the updated adage below:")
      adage.content = user_input.strip
      if adage.save
        say("Your edit has been saved.")
        return
      else
        say(adage.errors.full_messages.join)
      end
    end
  end

  def destroy(adage)
    Adage.destroy(adage.id)
    say("#{adage.content} has been deleted.")
    return
  end
end
