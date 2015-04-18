class InvitesController < ApplicationController

  def new
    @board = Board.find(params[:board_id])
  end

  def create
    @board = Board.find(params[:board_id])
    emails = sanitize_emails(params[:invites][:emails])

    invites = Invite.send_invites(emails, @board.id)
    if emails.empty?
      redirect_to new_board_invites_path(@board)
      flash[:error] = "Please enter up to five email addresses"

    elsif !invites[:invalid].empty? and !invites[:valid].empty?
      flash[:notice] = "Invites sent to #{invites[:valid].join(", ")} successfully!"
      flash[:error] = "Invites could not be sent to #{invites[:invalid].join(", ")}!"
      redirect_to new_board_invites_path(@board)

    elsif !invites[:valid].empty?
      flash[:notice] = "Invites sent to #{invites[:valid].join(", ")} successfully!"
      redirect_to board_path(@board)
    else
      flash[:error] = "Invites could not be sent to #{invites[:invalid].join(", ")}!"
      redirect_to new_board_invites_path(@board)      
    end
  end

  private
  def invites_params
    params.require(:invites).permit(:board_id, :emails)
  end

  def sanitize_emails emails
    emails.uniq.select { |e| !e.blank? }
  end

end
