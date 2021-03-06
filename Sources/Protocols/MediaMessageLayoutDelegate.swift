/*
 MIT License

 Copyright (c) 2017 MessageKit

 Permission is hereby granted, free of charge, to any person obtaining a copy
 of this software and associated documentation files (the "Software"), to deal
 in the Software without restriction, including without limitation the rights
 to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
 copies of the Software, and to permit persons to whom the Software is
 furnished to do so, subject to the following conditions:

 The above copyright notice and this permission notice shall be included in all
 copies or substantial portions of the Software.

 THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
 IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
 FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
 AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
 LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
 OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
 SOFTWARE.
 */

import AVFoundation

/// A protocol used by the `MessagesCollectionViewFlowLayout` object to determine
/// the size and layout of a `MediaMessageCell`s and its contents.
public protocol MediaMessageLayoutDelegate: MessagesLayoutDelegate {

    /// Specifies the width for a `MessageContainerView`.
    ///
    /// - Parameters:
    ///   - message: The `MessageType` that will be displayed by this cell.
    ///   - indexPath: The `IndexPath` of the cell.
    ///   - maxWidth: The max available width for the `MessageContainerView` respecting the cell's other content.
    ///   - messagesCollectionView: The `MessagesCollectionView` in which this cell will be displayed.
    ///
    /// The default value returned by this method is the `maxWidth`.
    func widthForMedia(message: MessageType, at indexPath: IndexPath, with maxWidth: CGFloat, in messagesCollectionView: MessagesCollectionView) -> CGFloat

    /// Specifies the height for a `MessageContainerView`.
    ///
    /// - Parameters:
    ///   - message: The `MessageType` that will be displayed by this cell.
    ///   - indexPath: The `IndexPath` of the cell.
    ///   - maxWidth: The max available width for the `MessageContainerView` respecting the cell's other content.
    ///   - messagesCollectionView: The `MessagesCollectionView` in which this cell will be displayed.
    ///
    /// The default value returned by this method uses `AVMakeRect(aspectRatio:insideRect:)` with a bounding
    /// rect using the `maxWidth` and `.greatestFiniteMagnitude` for the height.
    func heightForMedia(message: MessageType, at indexPath: IndexPath, with maxWidth: CGFloat, in messagesCollectionView: MessagesCollectionView) -> CGFloat
    
    func contentModeForMedia(message: MessageType, at indexPath: IndexPath, in messagesCollectionView: MessagesCollectionView) -> UIViewContentMode

}

public extension MediaMessageLayoutDelegate {
    
    func contentModeForMedia(message: MessageType, at indexPath: IndexPath, in messagesCollectionView: MessagesCollectionView) -> UIViewContentMode {
        return .center
    }

    func widthForMedia(message: MessageType, at indexPath: IndexPath, with maxWidth: CGFloat, in messagesCollectionView: MessagesCollectionView) -> CGFloat {
        return maxWidth
    }

    func heightForMedia(message: MessageType, at indexPath: IndexPath, with maxWidth: CGFloat, in messagesCollectionView: MessagesCollectionView) -> CGFloat {
        switch message.data {
        case .photo(let image), .video(_, let image):
            let boundingRect = CGRect(origin: .zero, size: CGSize(width: maxWidth, height: .greatestFiniteMagnitude))
            return AVMakeRect(aspectRatio: image.size, insideRect: boundingRect).height
        default:
            return 0
        }
    }
    
}
