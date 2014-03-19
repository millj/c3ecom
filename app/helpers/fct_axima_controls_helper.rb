module FctAximaControlsHelper

  def hold_or_remove_hold hold_status
    if hold_status
      link_to "Place on Hold", :controller => "fct_axima_controls", :action => "place_on_hold"
    else
      link_to "Remove Hold", :controller => "fct_axima_controls", :action => "remove_from_hold"
    end
  end

end
