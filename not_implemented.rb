=begin

def make_chop_prizes(new_prizes)
  Prize.destroy_by(tournament_id: id)
  i = 0
  while i < new_prizes.length
    make_prize(-1, new_prizes[i])
    i += 1
  end

end

  def chop(new_prizes)
    chop_sum = new_prizes.sum
    if chop_sum == remaining_prizepool
      make_chop_prizes(new_prizes)
      puts 'Chop successful'
    else
      puts <<~HEREDOC
        Cannot implement chop because the total of the new prizes is $#{chop_sum}
        and the remaining prizepool is $#{remaining_prizepool}
      HEREDOC
    end
  en


=end
