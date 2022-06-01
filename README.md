# Transferred Gaussian Graphical Model (Transferred GGM)
R implementation of the Transferred GGM algorithm. The main algorithm is in ` Transferred GGM run.R`.

---
A graphical model includes nodes to represent variables or features and edges to explicitly capture the statistical relationships between the variables of interest in the form of a graph. The edges can be undirected or directed. One of the most popular types of undirected graphical models is called the Gaussian Graphical Model (GGM), in which the nodes are assumed to follow a multivariate Gaussian distribution. (Wang et al. 2021. "Discriminant subgraph learning from functional brain sensory data")

It is widely applied in natural sciences, social sciences, economics, and many other fields.

Transferred GGM is a transfer learning approach adopting a Bayesian hierarchical model framework to characterize task relatedness for network modeling of multiple related tasks, which leverages the knowledge gained during the modeling of one task to help better model another task.

---

**We appreciate it if you would please cite our application paper as well as the original paper if you found the package useful for your work.**

Our application paper:
```
@article{chong2019homotopic,
  title={Homotopic region connectivity during concussion recovery: a longitudinal fMRI study},
  author={Chong, Catherine D and Wang, Lujia and Wang, Kun and Traub, Stephen and Li, Jing},
  journal={PloS one},
  volume={14},
  number={10},
  pages={e0221892},
  year={2019},
  publisher={Public Library of Science San Francisco, CA USA}
}
```
The original paper:
```
@article{huang2012transfer,
  title={A transfer learning approach for network modeling},
  author={Huang, Shuai and Li, Jing and Chen, Kewei and Wu, Teresa and Ye, Jieping and Wu, Xia and Yao, Li},
  journal={IIE transactions},
  volume={44},
  number={11},
  pages={915--931},
  year={2012},
  publisher={Taylor \& Francis}
}
```
