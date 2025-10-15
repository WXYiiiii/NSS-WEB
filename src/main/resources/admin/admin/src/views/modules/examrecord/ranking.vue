<template>
  <div class="main-content">
    <div class="page-header">
      <h2>知识排行榜</h2>
      <p>根据用户最高分数进行排名</p>
    </div>
    
    <el-form :inline="true" :model="searchForm" class="form-content">
      <el-form-item label="用户名">
        <el-input v-model="searchForm.username" placeholder="请输入用户名" clearable></el-input>
      </el-form-item>
      <el-form-item>
        <el-button type="primary" round @click="search()">查询</el-button>
        <el-button round @click="resetSearch()">重置</el-button>
      </el-form-item>
    </el-form>

    <div class="table-content">
      <el-table
        :data="dataList"
        border
        v-loading="dataListLoading"
        style="width: 100%;"
        :row-class-name="tableRowClassName"
      >
        <el-table-column
          type="index"
          header-align="center"
          align="center"
          width="100"
          label="排名"
        >
          <template slot-scope="scope">
            <div class="rank-cell">
              <span v-if="scope.$index === 0" class="rank-medal gold">🥇</span>
              <span v-else-if="scope.$index === 1" class="rank-medal silver">🥈</span>
              <span v-else-if="scope.$index === 2" class="rank-medal bronze">🥉</span>
              <span v-else class="rank-number">{{ scope.$index + 1 }}</span>
            </div>
          </template>
        </el-table-column>
        
        <el-table-column
          prop="username"
          header-align="center"
          align="center"
          label="用户名"
          width="200"
        >
          <template slot-scope="scope">
            <div class="username-cell">
              <i class="el-icon-user"></i>
              <span>{{ scope.row.username }}</span>
            </div>
          </template>
        </el-table-column>

        <el-table-column
          prop="myscore"
          header-align="center"
          align="center"
          label="最高分数"
          width="150"
          sortable
        >
          <template slot-scope="scope">
            <el-tag type="success" effect="dark" size="medium">
              {{ scope.row.myscore }} 分
            </el-tag>
          </template>
        </el-table-column>

        <el-table-column
          prop="paperCount"
          header-align="center"
          align="center"
          label="参与答题次数"
          width="150"
        >
          <template slot-scope="scope">
            <span class="paper-count">{{ scope.row.paperCount }}</span>
          </template>
        </el-table-column>

        <el-table-column
          header-align="center"
          align="center"
          label="荣誉称号"
        >
          <template slot-scope="scope">
            <el-tag v-if="scope.row.myscore >= 90" type="danger" effect="dark">
              <i class="el-icon-trophy"></i> 知识达人
            </el-tag>
            <el-tag v-else-if="scope.row.myscore >= 80" type="warning" effect="dark">
              <i class="el-icon-star-on"></i> 学习之星
            </el-tag>
            <el-tag v-else-if="scope.row.myscore >= 70" type="success">
              <i class="el-icon-medal"></i> 积极学员
            </el-tag>
            <el-tag v-else type="info">
              <i class="el-icon-reading"></i> 努力学习中
            </el-tag>
          </template>
        </el-table-column>
      </el-table>

      <el-pagination
        @size-change="sizeChangeHandle"
        @current-change="currentChangeHandle"
        :current-page="pageIndex"
        :page-sizes="[10, 20, 50, 100]"
        :page-size="pageSize"
        :total="totalPage"
        layout="total, sizes, prev, pager, next, jumper"
        class="pagination-content"
      ></el-pagination>
    </div>
  </div>
</template>

<script>
export default {
  data() {
    return {
      searchForm: {
        username: ""
      },
      dataList: [],
      pageIndex: 1,
      pageSize: 10,
      totalPage: 0,
      dataListLoading: false
    };
  },
  mounted() {
    this.getDataList();
  },
  methods: {
    // 获取数据列表
    getDataList() {
      this.dataListLoading = true;
      let params = {
        page: this.pageIndex.toString(),
        limit: this.pageSize.toString()
      };
      
      if (this.searchForm.username) {
        params.username = this.searchForm.username;
      }

      this.$http({
        url: "/examrecord/ranking",
        method: "get",
        params: params
      }).then(({ data }) => {
        if (data && data.code === 0) {
          this.dataList = data.data.list;
          this.totalPage = data.data.total;
        } else {
          this.dataList = [];
          this.totalPage = 0;
        }
        this.dataListLoading = false;
      }).catch(() => {
        this.dataListLoading = false;
      });
    },
    
    // 每页数
    sizeChangeHandle(val) {
      this.pageSize = val;
      this.pageIndex = 1;
      this.getDataList();
    },
    
    // 当前页
    currentChangeHandle(val) {
      this.pageIndex = val;
      this.getDataList();
    },
    
    // 搜索
    search() {
      this.pageIndex = 1;
      this.getDataList();
    },
    
    // 重置搜索
    resetSearch() {
      this.searchForm.username = "";
      this.pageIndex = 1;
      this.getDataList();
    },
    
    // 表格行样式
    tableRowClassName({row, rowIndex}) {
      if (rowIndex === 0) {
        return 'first-row';
      } else if (rowIndex === 1) {
        return 'second-row';
      } else if (rowIndex === 2) {
        return 'third-row';
      }
      return '';
    }
  }
};
</script>

<style lang="scss" scoped>
.main-content {
  background: #f5f7fa;
  padding: 20px;
  min-height: calc(100vh - 84px);
}

.page-header {
  background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
  padding: 30px;
  border-radius: 10px;
  margin-bottom: 20px;
  color: white;
  box-shadow: 0 4px 15px rgba(102, 126, 234, 0.4);
  
  h2 {
    margin: 0 0 10px 0;
    font-size: 28px;
    font-weight: bold;
  }
  
  p {
    margin: 0;
    font-size: 14px;
    opacity: 0.9;
  }
}

.form-content {
  background: white;
  padding: 20px;
  border-radius: 8px;
  margin-bottom: 20px;
  box-shadow: 0 2px 12px rgba(0, 0, 0, 0.1);
}

.table-content {
  background: white;
  padding: 20px;
  border-radius: 8px;
  box-shadow: 0 2px 12px rgba(0, 0, 0, 0.1);
}

.rank-cell {
  display: flex;
  justify-content: center;
  align-items: center;
  height: 60px;
  
  .rank-medal {
    font-size: 32px;
    line-height: 1;
    
    &.gold {
      animation: sparkle 2s infinite;
    }
  }
  
  .rank-number {
    font-size: 18px;
    font-weight: bold;
    color: #606266;
  }
}

.paper-count {
  font-size: 18px;
  font-weight: 600;
  color: #409EFF;
}

.username-cell {
  display: flex;
  justify-content: center;
  align-items: center;
  gap: 8px;
  
  i {
    color: #409EFF;
    font-size: 16px;
  }
  
  span {
    font-weight: 500;
  }
}

::v-deep .el-table {
  .el-table__row {
    height: 70px;
    
    .cell {
      line-height: 70px;
      padding: 0 10px;
    }
  }
  
  .first-row {
    background: #fff8e1 !important;
  }
  
  .second-row {
    background: #f5f5f5 !important;
  }
  
  .third-row {
    background: #fff3e0 !important;
  }
}

.pagination-content {
  margin-top: 20px;
  text-align: right;
}

@keyframes sparkle {
  0%, 100% {
    transform: scale(1);
  }
  50% {
    transform: scale(1.2);
  }
}

::v-deep .el-badge__content {
  background-color: #67C23A;
}
</style>

