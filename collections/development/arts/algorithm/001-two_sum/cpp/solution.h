#include <vector>
#include <map>
using namespace std;
class Solution {
public:
    vector<int> twoSum(vector<int>& nums, int target) {
        map<int, int> complements;
        for (int i = 0; i < nums.size(); i++) {
            int c = target - nums[i];
            if (complements[c]) {
                return vector<int>{complements[c] - 1, i};
            } else {
                complements[nums[i]] = i + 1;
            }
        }

        return vector<int>();
    }
};