module Response
  def response_to_get obj
    respond_to do |format|
      format.html
      format.json { render json: obj.as_json(include: params[:include].to_s.split(",").map { |v| v.to_sym }) }
      format.xml { render xml: obj, include: params[:include].to_s.split(",").map { |v| v.to_sym }}
    end
  end


  def success_response_to_post obj, location=nil, notice_message=""
    respond_to do |format|
      format.html { redirect_to location, notice: notice_message }
      format.json { render json: obj, status: :created}
      format.xml { render xml: obj, status: :created}
    end
  end


  def success_response_to_put obj
    respond_to do |format|
      format.json { render json: obj, status: :ok}
      format.xml { render xml: obj, status: :ok}
    end
  end


  def success_response_to_patch location=nil, notice_message=""
    respond_to do |format|
      format.html { redirect_to location, notice: notice_message }
      format.json { head :no_content }
      format.xml { head :no_content }
    end
  end


  def success_response_to_delete location=nil, notice_message=""
    respond_to do |format|
      format.html { redirect_to location, notice: notice_message }
      format.json { head :no_content }
      format.xml { head :no_content }
    end
  end


  def failure_response_to_post obj, location=nil, status = :unprocessable_entity
    respond_to do |format|
      format.html { render location}
      format.json { render json: obj, status: status }
      format.xml { render xml: obj, status: status }
    end
  end


  def failure_response_to_put obj, location=nil, status = :unprocessable_entity
    respond_to do |format|
      format.html { redirect_to location }
      format.json { render json: obj, status: status }
      format.xml { render xml: obj, status: status }
    end
  end


  def failure_response_to_delete obj, location=nil, status = :unprocessable_entity
    respond_to do |format|
      format.html { redirect_to location }
      format.json { render json: obj, status: status }
      format.xml { render xml: obj, status: status }
    end
  end
end
