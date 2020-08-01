class CandidatesController < ApplicationController

    before_action :find_candidate, only: [:show, :edit, :update, :destroy, :vote]

    def index
        @candidates = Candidate.all
    end

    def show
    end

    def new
        @candidate = Candidate.new
    end

    def edit
    end

    def update

        if @candidate.update(candidate_params)
            # flash[:notice] = "Candidate updated"
            redirect_to '/candidates', notice: 'Candidate updated'
        else
            render :edit
        end
    end

    def destroy
        @candidate.destroy

        flash[:notice] = "Candidate deleted"
        redirect_to '/candidates'

    end

    def create
        # clean_params = params.require(:candidate).permit(:name, :party, :age, :politics)
        @candidate = Candidate.new(candidate_params)
        if @candidate.save
            # OK
            # flash[:notice] = "Candidate created"
            redirect_to '/candidates', notice: 'Candidate created'
        else
            # NG
            # redirect_to '/candidates/new'
            render :new
        end
    end

    def vote

        # VoteLog.create(candidate: @candidate, ip_address: request.remote_ip)
        @candidate.vote_logs.create(ip_address: request.remote_ip)
        # @candidate.increment(:votes) # 同@candidate.votes = @candidate.votes + 1
        # @candidate.save

        # flash[:notice] = "Voted"
        redirect_to '/candidates', notice: 'Voted!'
    end

    private
    def candidate_params
        params.require(:candidate).permit(:name, :party, :age, :politics)
    end

    def find_candidate
        @candidate = Candidate.find_by(id: params[:id])
    end
end