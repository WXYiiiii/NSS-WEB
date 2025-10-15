<template>
  <mescroll-uni @init="mescrollInit" :up="upOption" :down="downOption" @down="downCallback" @up="upCallback">
    <view class="ranking-container">
      <view class="ranking-item" v-for="(item,index) in list" v-bind:key="index">
        <view class="ranking-left">
          <view class="ranking-badge" :class="getRankClass(index + 1)">
            <text class="ranking-number">{{index + 1}}</text>
          </view>
        </view>
        <view class="ranking-content">
          <view class="user-info">
            <text class="username">{{item.username}}</text>
          </view>
          <view class="score-info">
            <view class="score-item">
              <text class="cuIcon-circle text-red"></text>
              <text class="score-text">最高分：{{item.myscore}}分</text>
            </view>
            <view class="score-item" v-if="item.paperCount">
              <text class="cuIcon-edit text-blue"></text>
              <text class="score-text">答题次数：{{item.paperCount}}次</text>
            </view>
          </view>
        </view>
      </view>
    </view>
  </mescroll-uni>
</template>

<script>
export default {
  data() {
    return {
      list: [],
      mescroll: null,
      downOption: { auto: false },
      upOption: {
        // 进入页面自动触发第一次上拉加载
        auto: true,
        // 明确分页参数，保证 mescroll.num/size 有值
        page: { num: 1, size: 10 },
        noMoreSize: 5,
        textNoMore: '~ 没有更多了 ~',
      },
      hasNext: true
    }
  },
  methods: {
    mescrollInit(mescroll) {
      this.mescroll = mescroll;
    },
    downCallback(mescroll) {
      this.hasNext = true;
      mescroll.resetUpScroll();
    },
    async upCallback(mescroll) {
      let res = await this.$http({
        url: "examrecord/ranking",
        method: "get",
        params: {
          page: mescroll.num,
          limit: mescroll.size
        }
      });
      if (mescroll.num == 1) this.list = [];
      this.list = this.list.concat(res.data.list);
      if (res.data.list.length == 0) this.hasNext = false;
      mescroll.endSuccess(mescroll.size, this.hasNext);
    },
    getRankClass(rank) {
      if (rank === 1) return 'rank-gold';
      if (rank === 2) return 'rank-silver';
      if (rank === 3) return 'rank-bronze';
      return 'rank-normal';
    }
  }
}
</script>

<style scoped>
.ranking-container {
  padding: 20rpx;
  background-color: #f5f5f5;
}

.ranking-item {
  display: flex;
  align-items: center;
  background-color: #ffffff;
  margin-bottom: 20rpx;
  padding: 30rpx 20rpx;
  border-radius: 16rpx;
  box-shadow: 0 4rpx 12rpx rgba(0, 0, 0, 0.08);
  min-height: 150rpx;
}

.ranking-left {
  display: flex;
  align-items: center;
  margin-right: 24rpx;
}

.ranking-badge {
  width: 80rpx;
  height: 80rpx;
  border-radius: 50%;
  display: flex;
  align-items: center;
  justify-content: center;
  font-weight: bold;
  font-size: 32rpx;
}

.ranking-number {
  color: #ffffff;
}

.rank-gold {
  background: linear-gradient(135deg, #FFD700 0%, #FFA500 100%);
  box-shadow: 0 4rpx 12rpx rgba(255, 215, 0, 0.4);
}

.rank-silver {
  background: linear-gradient(135deg, #C0C0C0 0%, #A8A8A8 100%);
  box-shadow: 0 4rpx 12rpx rgba(192, 192, 192, 0.4);
}

.rank-bronze {
  background: linear-gradient(135deg, #CD7F32 0%, #B87333 100%);
  box-shadow: 0 4rpx 12rpx rgba(205, 127, 50, 0.4);
}

.rank-normal {
  background: linear-gradient(135deg, #A3A9E4 0%, #8B92D6 100%);
  box-shadow: 0 4rpx 12rpx rgba(163, 169, 228, 0.3);
}

.ranking-content {
  flex: 1;
  display: flex;
  flex-direction: column;
  justify-content: center;
}

.user-info {
  margin-bottom: 16rpx;
}

.username {
  font-size: 32rpx;
  font-weight: 600;
  color: #333333;
}

.score-info {
  display: flex;
  flex-direction: column;
  gap: 12rpx;
}

.score-item {
  display: flex;
  align-items: center;
  gap: 8rpx;
}

.score-text {
  font-size: 28rpx;
  color: #666666;
  line-height: 40rpx;
}

.text-red {
  color: #e54d42;
  font-size: 28rpx;
}

.text-blue {
  color: #0081ff;
  font-size: 28rpx;
}
</style>