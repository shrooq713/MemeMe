import UIKit

class MemeCollectionViewController: UICollectionViewController ,UICollectionViewDelegateFlowLayout {
    var memes: [Meme]!{
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        return appDelegate.memes
    }
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath:IndexPath) {
        let meme = memes[indexPath.row]
        let detailController = self.storyboard!.instantiateViewController(withIdentifier: "DetailsVC") as! DetailsViewController
        detailController.VCImage = meme.memedImage
        navigationController?.pushViewController(detailController, animated: true)
    }
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return memes.count
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        collectionView.reloadData()
    }
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "MemeCell", for: indexPath) as! MemeCollectionViewCell
        cell.poster.image = memes[indexPath.row].memedImage
        return cell
    }
    var interItemSpacing: CGFloat{
        return 1
    }
    var numberOfItemsInRow: CGFloat{
        return 3
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 1
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return interItemSpacing
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let totalInterItemSpaces = (numberOfItemsInRow - 1) * interItemSpacing
        let collectionwidth = collectionView.frame.width - totalInterItemSpaces
        let itemWidth =  collectionwidth/numberOfItemsInRow
        return CGSize(width: itemWidth, height: itemWidth)
    }
    @IBAction func add(_ sender: Any){
        let addMeme = self.storyboard!.instantiateViewController(withIdentifier: "ViewController")
        navigationController!.pushViewController(addMeme, animated: true)
        
    }
    @IBAction func unwind(_ sender: UIStoryboardSegue) {}
    
}
