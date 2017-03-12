# n回に1回ブロックを実行するクラス
class ThinOuter
  @exec_counter = 0
  @period = 1

  def period
    @period
  end

  def period=(val)
    if @period != val
      @period = val
      @exec_counter = 0
    end
  end

  def exec(&block)
    @exec_counter += 1

    if @exec_counter >= @period
      block.call
      @exec_counter = 0
    end
  end
end
