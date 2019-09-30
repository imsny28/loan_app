class AttachmentsController < ApplicationController
  include Response

  def index
    session[:per_page_value] ||= 15
    session[:per_page_value] = params[:per_page].to_i if params[:per_page].present?
    @per_page = session[:per_page_value]

    @attachments = Attachment.all
    @attachments = @attachments.page(params[:page]).per(@per_page)

    if CUSTOM_FIELDS["attachments"].present?
      @fields = CUSTOM_FIELDS["attachments"]
    else
      @fields = Attachment.new.attributes.keys.sort
    end
  end

  def edit
    @attachment = Attachment.find_by(id: params[:id])
  end

  def create
    @attachment = Attachment.new(attachment_params)
    if @attachment.save
      success_response_to_post @attachment, attachments_path, "Attribute Option created successfully."
    else
      failure_response_to_post @attachment.errors, new_attachment_path
    end
  end

  def show
    @attachment = Attachment.find_by(id: params[:id])
  end

  def new
    @attachment = Attachment.new
  end

  def edit
    @attachment = Attachment.find_by(id: params[:id])
  end

  def update
    @attachment = Attachment.find_by(id: params[:id])
    if @attachment.update(attachment_params)
      success_response_to_patch attachments_path, "Collateral Type updated successfully."
    else
      failure_response_to_post @attachment.errors, :edit
    end
  end

  def destroy
    @attachment = Attachment.find_by(id: params[:id])
    if params[:archive]
      if @attachment.archived
        @attachment.archived = false
        msg = "#{@attachment.display_name} unarchived successfully."
      else
        @attachment.archived = true
        msg = "#{@attachment.display_name} archived successfully."
      end
      @attachment.save
    else
      msg = "#{@attachment.display_name} deleted successfully."
      @attachment.destroy
    end
    success_response_to_delete collateral_types_path, msg
  end

  private
  def attachment_params
    params.require(:attachment).permit(:name, :image)
  end
end
