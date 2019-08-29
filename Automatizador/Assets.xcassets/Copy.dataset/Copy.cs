using System.Threading.Tasks;
using MB.Fachada.IBK.Estruturas.Copy;
using Mercantil.MobileBank.Proxy.Contracts;
using Mercantil.MobileBank.Services;
using Prism.Events;

namespace Mercantil.MobileBank.Proxy
{
    public class Copy: MBProxyBase, ICopy
    {
        public Copy(IEventAggregator eventAggregator, 
            IInstanceParameters instanceparameter) : base("Copy/", eventAggregator, instanceparameter)
        {
        }

        public async Task<RetCarCopy> CarCopy(EntCarCopy entrada)
        {
            return await Post<RetCarCopy, EntCarCopy>("CarCopy", entrada);
        }

        public async Task<RetExeCopy> ExeCopy(EntExeCopy entrada)
        {
            return await Post<RetExeCopy, EntExeCopy>("ExeCopy", entrada);
        }
    }
}
